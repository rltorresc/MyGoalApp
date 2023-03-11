class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.boolean :private, null: false, default: false
      t.boolean :completed, null: false, default: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
