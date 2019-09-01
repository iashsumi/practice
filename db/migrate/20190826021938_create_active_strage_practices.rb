class CreateActiveStragePractices < ActiveRecord::Migration[5.2]
  def change
    create_table :active_strage_practices do |t|
      t.string :name

      t.timestamps
    end
  end
end
