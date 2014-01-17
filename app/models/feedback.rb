class Feedback < ActiveRecord::Base
  validates :email, :comment, presence: true
end
