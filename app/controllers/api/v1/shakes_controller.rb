class Api::V1::ShakesController < Api::V1::BaseController

  def create
    @user_uuid = shake_params[:uuid]
    @lng = shake_params[:lng].to_f
    @lat = shake_params[:lat].to_f
    @parameters = shake_params[:parameters]
    return_random_restaurant
    @restaurant = @restaurants.sample.id
    render json: @restaurant
  end

  private

  def shake_params
    params.permit(:uuid, :lng, :lat, :parameters)
  end

  def return_random_restaurant
    calculate_area
    @restaurants = Restaurant.where(lat: (@min_lat..@max_lat), long: (@min_lng..@max_lng))
  end

  def calculate_area
    @max_lat = @lat + 0.01
    @min_lat = @lat - 0.01
    @max_lng = @lng + 0.01
    @min_lng = @lng - 0.01
  end
end
