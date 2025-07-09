require "test_helper"

  class CategoryTest < ActiveSupport::TestCase
    test "should not save category without a name" do
    category = Category.new(description: "Missing name")
    assert_not category.save, "Saved the category without a name"
  end

end

#rails test test\models\category_test.rb