class CreatePersonTable < ActiveRecord::Migration
  def change
    create_table :person_tables do |t|
      t.string :name
      t.integer :house_id
    end
  end
end
