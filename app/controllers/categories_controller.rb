class CategoriesController < ApplicationController
  before_action :authenticate_user!
  after_action :save_my_previous_url, only: [:new, :edit]

  def save_my_previous_url
    session[:previous_url] = URI(request.referrer || '').path
  end

  def index
    @categories = current_user.categories.all
  end
  def show
    @category = Category.all.find(params[:id])
  end
  def new
    @category = current_user.categories.build
  end
  def create
    @category = current_user.categories.build(category_params)
      if @category.save
        redirect_to categories_path, notice: "Category successfully created"
      else
        render :new
      end
  end

  def edit
    @category = Category.all.find(params[:id])
  end
  def update
    @category = Category.all.find(params[:id])

    if @category.update(category_params)
      redirect_to session[:previous_url], notice: "Category updated"
    else
      render :edit
    end
  end
  def destroy
    @category = Category.all.find(params[:id])
    @category.destroy

    redirect_to categories_path, notice: "Category deleted"
  end

  private
  def category_params
    params.require(:category).permit(:name, :description, :user_id)
  end
end
