class CreatePhoneBookReceptions < ActiveRecord::Migration
  def change
    create_table :phone_book_receptions do |t|
      t.references :phone_book, index: true
      t.string :email

      t.timestamps
    end
  end
end
