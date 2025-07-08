class Task < ApplicationRecord
  belongs_to :category
  validates :task_name, presence: true
end