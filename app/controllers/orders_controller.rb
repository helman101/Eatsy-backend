class OrdersController < ApplicationController::API
  def index
    @orders = Order.all
    render json: { status: 'SUCCESS', message: 'Loaded orders', data: @orders }, status: :ok
  end
  
  def show
    @order = Order.find(params[:id])
    render json: { status: 'SUCCESS', message: 'Loaded order', data: @order }, status: :ok
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      render json: { status: 'SUCCESS', message: 'Saved order', data: @order }, status: :ok
    else
      render json: { status: 'ERROR', message: 'order not saved', data: @order.errors },
             status: :unprocessable_entry
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    render json: { status: 'SUCCESS', message: 'Deleted order', data: @order }, status: :ok
  end

  private

  def order_params
    params.require(:order).permit(:id, :customer_id, :food_id)
  end
end
  