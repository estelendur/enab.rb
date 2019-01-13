class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.decimal :allocation
      t.decimal :goal_amount
      t.date :due_date

      t.timestamps
    end
  end
end
