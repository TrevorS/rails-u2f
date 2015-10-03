class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :color
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :pets, :user_id
  end
end
