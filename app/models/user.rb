class User < ApplicationRecord
  has_many :emails, dependent: :destroy
  accepts_nested_attributes_for :emails, allow_destroy: true

  validates :name, presence: true
end
