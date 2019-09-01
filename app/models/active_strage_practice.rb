class ActiveStragePractice < ApplicationRecord
  has_one_attached :avatar

  validates :name, presence: true

  attr_accessor :avatar_blob_id
end
