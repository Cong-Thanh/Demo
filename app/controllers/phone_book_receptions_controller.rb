class PhoneBookReceptionsController < ApplicationController
  before_action :set_phone_book, only: [:create]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_phone_book

  def create
    @reception = @phone_book.phone_book_receptions.build phone_book_reception_params

    if @reception.save
      PhoneBookNotifier.send_contacts(@reception).deliver
      render json: { status: 200 }
    else
      render json: { status: 503 }
    end
  end

  private

  def set_phone_book
    @phone_book = PhoneBook.find(params[:phone_book_id])
  end

  def invalid_phone_book
    redirect_to phone_books_url
  end

  def phone_book_reception_params
    params.require(:phone_book_reception).permit(:email)
  end
end
