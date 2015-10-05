class U2fRegistrationsController < ApplicationController
  include U2fHelper

  before_action :authenticate_user!

  def index
    @u2f_devices = current_user.u2f_devices
  end

  def new
    @u2f_device = U2fDevice.new
    @user       = current_user

    @registration_requests = u2f.registration_requests
    session[:challenges]   = @registration_requests.map(&:challenge)

    key_handles    = @user.u2f_devices.pluck(:key_handle)
    @sign_requests = u2f.authentication_requests(key_handles)
  end

  def create
    u2f_response = U2F::RegisterResponse.load_from_json(params[:response])
    u2f_request  = u2f_request(u2f_response)

    u2f_device = current_user.u2f_devices.build(u2f_device_params(u2f_request))

    if u2f_device.save
      redirect_to user_u2f_registrations_url(current_user), notice: 'U2F Device was successfully created.'
    else
      render :new
    end
  end

  def destroy
    u2f_device = U2fDevice.find(params[:id])

    if u2f_device.destroy
      redirect_to user_u2f_registrations_url(current_user), notice: 'U2F Device was successfully destroyed.'
    else
      redirect_to user_u2f_registrations_url(current_user), notice: 'U2F Device was was unable to be destroyed.'
    end
  end

  private

  def u2f_request(u2f_response)
    u2f.register!(session[:challenges], u2f_response)
  rescue U2F::Error => error
    Rails.logger.debug("U2F Error: #{error.message}")
  ensure
    session.delete(:challenges)
  end

  def u2f_device_params(u2f_request)
    {
      key_handle: u2f_request.key_handle, public_key: u2f_request.public_key,
      certificate: u2f_request.certificate, counter: u2f_request.counter
    }
  end
end
