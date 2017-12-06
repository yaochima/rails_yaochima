class Api::V1::RestaurantsController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User, except: [:create]
  before_action :set_restaurant, only: [ :show ]

  def show
    render json: @restaurant
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
