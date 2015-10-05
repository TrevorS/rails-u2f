class U2fAuthenticationsController < ApplicationController
  include U2fHelper

  before_action :authenticate_user!
  before_action :set_key_handles!, only: :new
  before_action :set_u2f_device!, only: :create

  def new
    @sign_requests = u2f.authentication_requests(@key_handles)
    session[:challenges] = @sign_requests.map(&:challenge)
  end

  def create
    if u2f_authenticate(@u2f_response, @u2f_device)
      @u2f_device.update(counter: @u2f_response.counter)
      redirect_to root_path, notice: 'Successful login using U2F.'
    else
      render :new, notice: 'Could not login using U2F.'
    end
  end

  private

  def set_key_handles!
    unless @key_handles = current_user.u2f_devices.pluck(:key_handle)
      redirect_to root_path, notice: 'You must set up a U2F device first.'
    end
  end

  def set_u2f_device!
    @u2f_response = U2F::SignResponse.load_from_json(params[:response])
    unless @u2f_device = current_user.u2f_devices.find_by(key_handle: @u2f_response.key_handle)
      redirect_to root_path, notice: 'You must set up a U2F device first.'
    end
  end

  def u2f_authenticate(u2f_response, u2f_device)
    u2f.authenticate!(session[:challenges], u2f_response, Base64.decode64(u2f_device.public_key), u2f_device.counter)

    true
  rescue U2F::Error => error
    Rails.logger.debug("U2F Error: #{error.message}")
    false
  ensure
    session.delete(:challenges)
  end
end
