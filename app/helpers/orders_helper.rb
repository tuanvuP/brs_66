module OrdersHelper
  def total_each_order_detail order_detail
    order_detail.current_price * order_detail.quantity
  end

  def check_cart
  	unless session["cart"].present?
      flash[:danger] = t ".empty"
      redirect_to root_path
    end
  end
end
