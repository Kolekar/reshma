class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.float :snf
      t.float :fat, null: false
      t.float :degree
      t.float :rate, null: false
      t.boolean :animal_type, null: false

      t.timestamps null: false
    end

    # add_index :releases, [:snf, :fat, :degree], unique: true
  end
end
