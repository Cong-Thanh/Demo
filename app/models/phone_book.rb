class PhoneBook < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :phone_book_receptions, dependent: :destroy

  after_create :create_default_contact
  
  protected

  def create_default_contact
    contacts.create(name: "Thanh Nguyen", phone: "1231231234", email: "thanh.nguyen.10008@gmail.com")
  end

end
