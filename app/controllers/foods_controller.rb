class FoodsController < ApplicationController
  def index
    @foods = Food.all
    render json: { message: 'Loaded foods', data: @foods }
  end

  def show
    begin 
      @food = Food.find(params[:id])
    rescue
      render json: {
        errors: ['food not found']
      },
      status: :not_found
    else
      render json: { message: 'Loaded food', data: @food }
    end
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      render json: { message: 'Saved food', data: @food }, status: :created
    else
      render json: { message: 'food not saved', data: @food.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @food = Food.find(params[:id])
    rescue
      render json: {
        errors: ['food not found']
      },
      status: :not_found
    else
      @food.destroy
      render json: { message: 'Deleted food'}
    end
  end
  
  private

  def food_params
    params.require(:food).permit(:name, :price, :description, :image)
  end
end