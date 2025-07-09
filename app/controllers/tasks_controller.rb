class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_task, only: [:edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from StandardError, with: :handle_generic_error unless Rails.env.development?

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to category_path(@category), notice: 'Task updated successfully.'
    else
      flash.now[:alert] = "Please correct the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @task = @category.tasks.build(task_params)

    if @task.save
      redirect_to category_path(@category), notice: 'Task was successfully added.'
    else
      flash.now[:alert] = "Task name is required."
      render 'categories/show', status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to category_path(@category), notice: 'Task was successfully deleted.'
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :description, :due_date)
  end

  def handle_record_not_found
    redirect_to categories_path, alert: "The task or category you were looking for doesn't exist."
  end

  def handle_generic_error(exception)
    logger.error exception.message
    logger.error exception.backtrace.join("\n")
    redirect_to categories_path, alert: "An unexpected error occurred in tasks. Please try again."
  end
end
