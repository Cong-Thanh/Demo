class CreatePhoneBooks < ActiveRecord::Migration
  def change
    create_table :phone_books do |t|

      t.timestamps
    end
  end
end
