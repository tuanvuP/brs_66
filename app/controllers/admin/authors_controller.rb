class Admin::AuthorsController < Admin::AdminController
  before_action :load_author, except: %i(index new create)

  def index
    @authors = Author.search(params[:search])
                     .page(params[:page])
                     .per Settings.per_page
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t ".success"
      redirect_to admin_authors_path
    else
      flash[:error] = t ".error"
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    if @author.update_attributes author_params
      flash[:success] = t ".update_success"
      redirect_to admin_authors_path
    else
      flash[:error] = t ".error"
      render :edit
    end
  end

  private

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:warning] = t ".not_exist"
    redirect_to admin_authors_path
  end

  def author_params
    params.require(:author).permit :name, :brith_year, :phone,
      :address
  end
end
