module FavoritesHelper
  def current_favorites
    current_user.current_favorite @book
  end

  def unfavorite
    current_user.favorites.build
  end
end
