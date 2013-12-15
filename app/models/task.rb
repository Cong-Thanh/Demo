class Task < ActiveRecord::Base
  has_many :task_items, dependent: :destroy
end
