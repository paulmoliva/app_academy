class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.string :name, null:false
      t.integer :toyable_id, null:false
      t.string :toyable_type, null:false
      t.timestamps null: false
    end
  end
end
