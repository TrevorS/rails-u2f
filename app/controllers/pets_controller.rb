class PetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def index
    @pets = current_user.pets
  end

  def show
  end

  def new
    @pet  = Pet.new
    @user = current_user
  end

  def edit
  end

  def create
    @pet = current_user.pets.build(pet_params)

    if @pet.save
      redirect_to @pet, notice: 'Pet was successfully created.'
    else
      render :new
    end
  end

  def update
    if @pet.update(pet_params)
      redirect_to @pet, notice: 'Pet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @pet.destroy
    redirect_to user_pets_url(current_user), notice: 'Pet was successfully destroyed.'
  end

  private

  def set_pet
    @pet = current_user.pets.find_by(id: params[:id])
  end

  def pet_params
    params.require(:pet).permit(:color)
  end
end
