class PhoneBook < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :phone_book_receptions, dependent: :destroy
end
