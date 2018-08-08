module CartsHelper
  def sub_total book
    session[:cart][book.id.to_s] * book.price
  end

  def total_money
    @cart = session[:cart]
    sum = 0
    @cart.each do |key, val|
      sum += val * Book.by_id(key)[0].price
    end
    sum
  end

  def quantity book
    session["cart"][book.id.to_s]
  end

  def load_book_in_cart
  	if session["cart"].blank?
  	  flash[:danger] = t ".danger"
        redirect_to books_path
  	else
  	  @book_in_cart = Book.by_book_ids session["cart"].keys
  	end
  end
end
