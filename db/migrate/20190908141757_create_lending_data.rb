class CreateLendingData < ActiveRecord::Migration[5.2]
  def change
    create_table :lending_data do |t|
      t.references :user
      t.date :checkout_date
      t.date :return_date

      t.timestamps
    end
  end
end
