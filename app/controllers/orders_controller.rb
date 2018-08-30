  class OrdersController < ApplicationController
  before_action :logged_in_user, :check_cart, only: %i(new create)
  before_action :find_order, only: :show

  def index
    @orders = Order.by_id current_user.id
  end

  def show
    @order_details = @order.order_details.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new order_params
    @order.total = total_money
    @flag = ActiveRecord::Base.transaction do
      @order.save!
      session[:cart].each do |key, val|
        @order_detail = OrderDetail.create! book_id: key.to_i,
          order_id: @order.id, quantity: val, current_price: load_item(key.to_i).price
      end
    end
    session.delete :cart
    flash[:success] = t ".create_order_success"
    redirect_to orders_path
  end

  def update
    @order = Order.find_by id: params[:id]
    @order.update_attributes status: params[:status]
    redirect_to orders_path
  end

  private
  def order_params
    params.require(:order).permit :full_name, :phone, :address, :user_id, :status
  end

  def find_order
    @order = Order.find_by id: params[:id]
    return if @order
  end
end
