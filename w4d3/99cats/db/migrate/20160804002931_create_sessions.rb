class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.integer :location
      t.integer :device
      t.string :token, null: false

      t.timestamps null: false
    end
  end
end
