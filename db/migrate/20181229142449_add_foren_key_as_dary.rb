class AddForenKeyAsDary < ActiveRecord::Migration[5.0]
  def change
  	add_reference :rates, :dairy, index: true
  	add_reference :users, :dairy, index: true
  	add_reference :collections, :dairy, index: true
  end
end
