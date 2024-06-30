class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy] #@restaurant = Restaurant.find(params[:id])
  def index
    @restaurants = Restaurant.order(created_at: :desc)
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      respond_to do |format|
        format.html { redirect_to restaurant_path(@restaurant) }
        format.turbo_stream
      end
      redirect_to @restaurant
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path, status: :see_other
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
