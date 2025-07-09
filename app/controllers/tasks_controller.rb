class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_task, only: [:edit, :update, :destroy]

  def create
    @task = @category.tasks.build(task_params)

    if @task.save
      redirect_to category_path(@category), notice: 'Task was successfully created.'
    else
      flash.now[:alert] = 'There was a problem adding your task.'
      render 'categories/show', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to category_path(@category), notice: 'Task updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to category_path(@category), notice: 'Task deleted.'
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
end
