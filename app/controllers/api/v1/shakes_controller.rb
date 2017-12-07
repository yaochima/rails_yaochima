class Api::V1::ShakesController < Api::V1::BaseController

  def create
    #save parameters
    # @user_uuid = shake_params[:client_uuid]
    # @session_uuid = shake_params[:session_uuid]
    @lng = shake_params[:lng].to_f
    @lat = shake_params[:lat].to_f
    @parameters = shake_params[:parameters]
    #return a random restaurant
    return_random_restaurant
    #create session if it does not exists OR assign it to sessions
    # check_session
    #create shake
    # create_shake
    #render response
    render json: @restaurant
  end

  private

  def shake_params
    params.permit(:client_uuid, :session_uuid, :lng, :lat, :parameters)
  end

  def return_random_restaurant
    calculate_area

    @restaurant = Restaurant.where(lat: (@min_lat..@max_lat), lng: (@min_lng..@max_lng)).sample.id
  end

  def calculate_area
    @max_lat = @lat + 0.05
    @min_lat = @lat - 0.05
    @max_lng = @lng + 0.05
    @min_lng = @lng - 0.05
  end

  # def check_session
  #   if Session.find_by_session_uuid(shake_params[:session_uuid])
  #     @session = Session.find_by_session_uuid(shake_params[:session_uuid])
  #   else
  #     @session = Session.new
  #     @session.session_uuid = shake_params[:session_uuid]
  #     @session.user_id = User.find_by_uuid(shake_params[:client_uuid]).id
  #     p User.find_by_uuid(shake_params[:client_uuid])
  #     @session.lat = @lat
  #     @session.lng = @lng
  #     @session.save
  #   end
  # end

  # def create_shake
  #   shake = Shake.new
  #   shake.restaurant_id = @restaurant
  #   shake.session_id = @session.id
  #   shake.parameters = @parameters
  #   shake.save
  # end
end
