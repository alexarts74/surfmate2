class Api::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: { message: 'Inscription réussie !', user: resource }
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name), status: Devise.responder.redirect_status }
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :age, :level, :bio, :email, :password, :image)
  end
end
