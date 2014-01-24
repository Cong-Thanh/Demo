class PhoneBooksController < ApplicationController
  before_action :set_phone_book, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_phone_book

  def index
    @phone_book = PhoneBook.create!
    redirect_to @phone_book
  end

  def show
    if params[:set_locale]
      redirect_to phone_book_path(locale: params[:set_locale], phone_book: @phone_book)
    end
  end

  private

  def set_phone_book
    @phone_book = PhoneBook.find(params[:id])
  end

  def invalid_phone_book
    redirect_to phone_books_url
  end
end
