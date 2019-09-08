class CreateBorrowedBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :borrowed_books do |t|
      t.references :lending_datum
      t.references :book

      t.timestamps
    end
  end
end
