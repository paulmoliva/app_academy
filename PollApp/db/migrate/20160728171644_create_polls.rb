class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.timestamps null: false
    end

    add_index :polls, :user_id
  end
end
