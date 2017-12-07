class Api::V1::ShakesController < Api::V1::BaseController

  def create
    #save parameters
    # @user_uuid = shake_params[:client_uuid]
    # @session_uuid = shake_params[:session_uuid]
    @lng = shake_params[:lng].to_f
    @lat = shake_params[:lat].to_f
    @exclusions = shake_params[:exclusions]
    @locked_category = shake_params[:lockedcategory]
    @locked_price = shake_params[:lockedprice].to_i
    #return a random restaurant
    return_random_restaurant
    #create session if it does not exists OR assign it to sessions
    # check_session
    #create shake
    # create_shake
    #render response
    p "exclusions"
    p @exclusions
    p "locked_category"
    p @locked_category
    p "locked_price"
    p @locked_price





    p @restaurant
    render json: @restaurant
  end

  private

  def shake_params
    params.permit(:lng, :lat, :exclusions, :lockedcategory, :lockedprice)
  end

  def return_random_restaurant
    return_restaurant_list
    @restaurant = @restaurants.near([@lat, @lng], 1, :units => :km).sample.id
    # @restaurants = Restaurant.near([@lat, @lng], 10, :units => :km).sample.id
    # @restaurants = @restaurants.where(category: @locked_category)
  end

  def return_restaurant_list
    @restaurants = Restaurant.all
    if @locked_category
      @restaurants = @restaurants.where(category: @locked_category)
    elsif @exclusions != "[]" || !@exclusions.nil?
      @exclusions.each do |food_category|
        p food_category
        @restaurants = @restaurants.where.not(category: food_category)
      end
    end
    if @locked_price != 0
      p @locked_price
      calculate_price_range
      @restaurants = @restaurants.where(price_per_person: @min_price..@max_price)
    end
  end

  def calculate_price_range
    if @locked_price
      @max_price = @locked_price * 1.05
      @min_price = @locked_price * 0.75
    end
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
