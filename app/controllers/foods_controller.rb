class FoodsController < ApplicationController::API
  def index
    @orders = Foods.all
    render json: { status: 'SUCCESS', message: 'Loaded foods', data: @foods }, status: :ok
  end

  def show
    @food = Food.find(params[:id])
    render json: { status: 'SUCCESS', message: 'Loaded food', data: @food }, status: :ok
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      render json: { status: 'SUCCESS', message: 'Saved food', data: @order }, status: :ok
    else
      render json: { status: 'ERROR', message: 'food not saved', data: @food.errors },
             status: :unprocessable_entry
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    render json: { status: 'SUCCESS', message: 'Deleted order', data: @food }, status: :ok
  end
  
  private

  def food_params
    params.require(:food).permit(:name, :price, :description)
  end
end