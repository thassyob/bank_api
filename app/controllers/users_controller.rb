class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
   user = User.create!(create_params)
   render json: user, status: :created,
     serializer: Users::Create::UsersSerializer
  end

  private

  def create_params
    params.require(:user).permit(:name)
  end
end
