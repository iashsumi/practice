class User < ApplicationRecord
  has_many :emails, dependent: :destroy
  accepts_nested_attributes_for :emails, allow_destroy: true

  validates :name, presence: true

  def self.bulk_insert(file)
    users = []
    CSV.foreach(file.path, headers: true) do |row|
      user = new
      user.attributes = row.to_hash.slice(*updatable_attributes)
      users << user
    end
    User.import(users)
  end

  def self.updatable_attributes
    ["name"]
  end
end
