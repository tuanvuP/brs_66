class Admin::OrdersController < Admin::AdminController
  before_action :load_order, only: :update

  def index
    @order_unchecked = Order.by_status Settings.order.unchecked
    @order_checked = Order.by_status Settings.order.checked
  end

  def update
    @order.update_attributes status: params[:status]
    Admin::OrderMailer.notice_request(@order).deliver_now
    flash[:info] = t ".sent_email"
    redirect_to admin_orders_path
  end
end
