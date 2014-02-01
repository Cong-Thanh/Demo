namespace :demo do
  namespace :add do
    desc "Add default contact to phone book"
    task :default_contact => :environment do
      PhoneBook.find_each do |phone_book| 
        phone_book.contacts.create name: CONFIG[:name],  phone: CONFIG[:phone], email: CONFIG[:email] if phone_book.contacts.empty?
     end
    end
  end
end