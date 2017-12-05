class Api::V1::UsersController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User, except: [:create]

  def create
    uuid = params[:uuid]
    @user = User.find_by_uuid(uuid) || User.create!(user_params(uuid))
    render json: @user
  end

  private

  def user_params(uuid)
    user_params = {}
    user_params['uuid'] = uuid
    user_params['email'] = "#{uuid}@yaochi.ma"
    user_params['password'] = Devise.friendly_token
    user_params
  end

end
