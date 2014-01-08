class PhoneBookReception < ActiveRecord::Base
  belongs_to :phone_book

  validates :email, presence: true
end
