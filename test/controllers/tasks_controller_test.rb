require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user # if using Devise and helpers

    @category = categories(:one)
    @task = tasks(:one)
  end

  test "should get edit" do
    get edit_category_task_path(@category, @task)
    assert_response :success
  end

  test "should update task" do
    patch category_task_path(@category, @task), params: {
      task: {
        task_name: "Updated Task Name",
        description: "Updated description",
        due_date: Date.today
      }
    }

    assert_redirected_to category_path(@category)
    @task.reload
    assert_equal "Updated Task Name", @task.task_name
  end

  test "should not update task with invalid data" do
    patch category_task_path(@category, @task), params: {
      task: {
        task_name: "" # Invalid
      }
    }

    assert_response :unprocessable_entity
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete category_task_path(@category, @task)
    end

    assert_redirected_to category_path(@category)
  end
end

#rails test test\controllers\tasks_controller_test.rb