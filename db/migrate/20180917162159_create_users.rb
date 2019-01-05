class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :mobile, null: false
      t.string :name, null: false
      t.text :address, null: false
      t.boolean :animal_type, null: false

      t.timestamps null: false
    end
  end
end
