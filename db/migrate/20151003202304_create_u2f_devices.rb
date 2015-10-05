class CreateU2fDevices < ActiveRecord::Migration
  def change
    create_table :u2f_devices do |t|
      t.string :key_handle
      t.string :public_key
      t.string :certificate
      t.integer :counter
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :u2f_devices, :user_id
  end
end
