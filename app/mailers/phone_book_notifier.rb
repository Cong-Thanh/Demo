class PhoneBookNotifier < ActionMailer::Base
  default from: "Thanh Nguyen <thanh.nguyen.10008@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.phone_book_notifier.send_contacts.subject
  #
  def send_contacts(phone_book_reception)
    @phone_book = phone_book_reception.phone_book

    mail to: phone_book_reception.email, subject: I18n.t('phone_book_notifier.subject')
  end
end
