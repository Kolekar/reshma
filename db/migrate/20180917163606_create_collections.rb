class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.float :rate, null: false
      t.float :snf
      t.float :fat, null: false
      t.float :degree
      t.boolean :animal_type, null: false
      t.boolean :time, null: false
      t.float :litre, null: false
      t.integer :user_id, null: false
      t.date :collection_date, null: false

      t.timestamps null: false
    end
    add_index :collections, :user_id
  end
end
