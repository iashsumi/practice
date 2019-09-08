class BorrowedBook < ApplicationRecord
  belongs_to :lending_datum
  belongs_to :book
end
