class OrdersController < ApplicationController
  def index
    @orders = Order.all
    render json: { message: 'Loaded orders', data: @orders }
  end
  
  def show
    begin 
      @order = Order.find(params[:id])
    rescue
      render json: {
        errors: ['order not found']
      },
      status: :not_found
    else
      render json: { message: 'Loaded order', data: @order }
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      render json: { message: 'Saved order', data: @order }, status: :created
    else
      render json: { message: 'order not saved', data: @order.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @order = Order.find(params[:id])
    rescue
      render json: {
        errors: ['order not found']
      },
      status: :not_found
    else
      @order.destroy
      render json: { message: 'Deleted order'}
    end
  end

  private

  def order_params
    params.require(:order).permit(:id, :customer_id, :food_id)
  end
end
  