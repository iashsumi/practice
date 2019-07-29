class Email < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.references :user, foreign_key: true
      t.string :email
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
