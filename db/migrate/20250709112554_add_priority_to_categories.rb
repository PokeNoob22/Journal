class AddPriorityToCategories < ActiveRecord::Migration[7.2]
  def change
    add_column :categories, :priority, :boolean
  end
end
