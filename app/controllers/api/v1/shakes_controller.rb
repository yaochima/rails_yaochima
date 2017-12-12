class Api::V1::ShakesController < Api::V1::BaseController

  def create
    #save parameters
    # @user_uuid = shake_params[:client_uuid]
    # @session_uuid = shake_params[:session_uuid]
    @lng = params[:lng].to_f
    @lat = params[:lat].to_f
    p params[:lng]
    p params[:lat]
    @exclusions = params[:exclusions]
    @locked_category = params[:lockedcategory]
    @locked_price = params[:lockedprice].to_i
    p "exclusions"
    p @exclusions
    p "locked_category"
    p @locked_category
    p "locked_price"
    p @locked_price
    #return a random restaurant
    @radius_km = 1
    return_random_restaurant
    #create session if it does not exists OR assign it to sessions
    # check_session
    #create shake
    # create_shake
    #render response






    p @restaurant

    @restaurant
    if @error_message.nil?
      render json: { status: "ok",
                     restaurants: {
                     id: @restaurant
                    }}
    elsif @error_message
      render json: { status: "error" ,
                     error: {
                     error_message: @error_message
                      }}
    end
  end

  private

  # def shake_params
  #   params.permit(:lng, :lat, :exclusions, :lockedcategory, :lockedprice)
  # end

  def return_random_restaurant
    p "RUN RETURN"
    return_near_restaurant_list
    return_rated_restaurant_list
    return_category_restaurant_list
    return_price_restaurant_list

    @restaurants = @restaurants.near([@lat, @lng], @radius_km, :units => :km)
    if @error_message.nil?
      @restaurant = @restaurants.sample
    end


    # return_restaurant_list

    # #future radius extension
    # # [ 1, 1.5, 2, 2,5, 3 ].each do |radius|
    # #   if @restaurants.near([@lat, @lng], radius, :units => :km).sample.id
    # #     return @restaurant = @restaurants.near([@lat, @lng], radius, :units => :km).sample.id
    # #   end
    # # end
    # p "INITIATE"
    # @restaurants.near([@lat, @lng], 1, :units => :km)
    # p @restaurants.class
    # if @restaurants.first.nil?

    #   @error_message = "There are no more category available"
    #   @exclusions = []
    #   return_random_restaurant
    # else
    #   @restaurant = @restaurants.sample.id
    # end
    # # @restaurants = Restaurant.near([@lat, @lng], 10, :units => :km).sample.id
    # # @restaurants = @restaurants.where(category: @locked_category)
  end

  def return_near_restaurant_list
    @restaurants = Restaurant.all
    @restaurants = @restaurants.near([@lat, @lng], @radius_km, :units => :km)
    if @restaurants.first.nil?
      if @radius_km == 3.0
        @error_message = "没找到合适的结果…… 再摇一摇"
      else
        @radius_km += 0.5
        return_restaurant_list
      end
    end
  end

  def return_rated_resstaurant_list
    @restaurants = @restaurants.where(rating: 3..6)
    @restaurants = @restaurants.where.not(price_per_person: 0)
    if @restaurants.first.nil?
      if @radius_km == 3.0
        @error_message = "没找到合适的结果…… 再摇一摇"
      else
        @radius_km += 0.5
        return_restaurant_list
      end
    end
  end

  def return_category_restaurant_list
    if @locked_category
      @restaurants = @restaurants.where(category: @locked_category)
      if @restaurants.first.nil?
        if @radius_km == 3.0
          @error_message = "没找到合适的结果…… 再摇一摇"
        else
          @radius_km  += 0.5
          return_random_restaurant
        end
      end
    elsif !@exclusions.nil?
      @exclusions.each do |food_category|
        @restaurants = @restaurants.where.not(category: food_category)
        if @restaurants.first.nil?
          if @radius_km == 3.0
            @error_message = "没找到合适的结果…… 再摇一摇"
          else
            @radius_km  += 0.5
            return_random_restaurant
          end
        end
      end
    end
  end

  def return_price_restaurant_list
    if @locked_price != 0
      @max_price = @locked_price * 1.05
      @min_price = @locked_price * 0.75
      @restaurants = @restaurants.where(price_per_person: @min_price..@max_price)
      if @restaurants.first.nil?
        if @radius_km == 3.0
          @error_message = "没找到合适的结果…… 再摇一摇"
        else
          @radius_km  += 0.5
          return_random_restaurant
        end
      end
    end
  end


  def return_restaurant_list
    @restaurants = Restaurant.all
    if @locked_category
        @restaurants = @restaurants.where(category: @locked_category)
    elsif !@exclusions.nil?
      @exclusions.each do |food_category|
        @restaurants = @restaurants.where.not(category: food_category)
      end
    end
    if @locked_price != 0
      p @locked_price
      calculate_price_range
      @restaurants = @restaurants.where(price_per_person: @min_price..@max_price)
    end
  end

  def return_locked_category_restaurant_list
    @restaurants = @restaurants.where(category: @locked_category)
    if @restaurants.first.nil?
      @error_message = "没找到合适的结果…… 再摇一摇"
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
