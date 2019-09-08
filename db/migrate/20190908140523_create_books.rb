class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.references :publisher
      t.references :author
      t.date :release_date

      t.timestamps
    end
  end
end
