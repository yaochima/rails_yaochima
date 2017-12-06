class Api::V1::ShakesController < Api::V1::BaseController

  def create
    @user_uuid = shake_params[:uuid]
    @long = shake_params[:long]
    @lat = shake_params[:lat]
    @restaurant = Restaurant.all.sample.id
    render json: @restaurant
  end

  private

  def shake_params
    params.permit(:uuid, :long, :lat)
  end


end
