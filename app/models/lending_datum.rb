class LendingDatum < ApplicationRecord
  belongs_to :user
  has_many :borrowed_books, dependent: :destroy
end
