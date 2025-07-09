class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from StandardError, with: :handle_generic_error unless Rails.env.development?

  def index
    @categories = current_user.categories
  end

  def show
    @task = @category.tasks.build
  end

  def new
    @category = current_user.categories.build
  end

  def edit; end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      flash.now[:alert] = "Please fill in the required fields."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      flash.now[:alert] = "Please correct the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category and all its tasks were successfully deleted.'
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:category_name, :description, :priority)
  end

  def handle_record_not_found
    redirect_to categories_path, alert: "The category you were looking for doesn't exist."
  end

  def handle_generic_error(exception)
    logger.error exception.message
    logger.error exception.backtrace.join("\n")
    redirect_to categories_path, alert: "An unexpected error occurred in categories. Please try again."
  end
end
