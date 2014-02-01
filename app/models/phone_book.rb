class PhoneBook < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :phone_book_receptions, dependent: :destroy

  after_create :create_default_contact
  
  protected
  
  def create_default_contact
    contacts.create name: CONFIG[:name], phone: CONFIG[:phone], email: CONFIG[:email]
  end

end
