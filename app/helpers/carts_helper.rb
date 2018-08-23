module CartsHelper
  def sub_total book
    session[:cart][book.id.to_s] * book.price
  end

  def total_money
    @cart = session[:cart]
    sum = 0
    if @cart
      @cart.each do |key, val|
        sum += val * Book.by_id(key)[0].price
      end
    end
    sum
  end

  def quantity book
    session[:cart][book.id.to_s]
  end

  def load_book_in_cart
  	@book_in_cart = session[:cart].present? ? Book.by_id(session[:cart].keys) : nil
  end
end
