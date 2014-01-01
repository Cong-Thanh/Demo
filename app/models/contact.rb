class Contact < ActiveRecord::Base
  belongs_to :phone_book
  
  validates :name, :phone, :email, presence: true
end
