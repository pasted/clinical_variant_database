class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.integer :protein_sequence_variant_id
    	t.integer :score
      t.string :prediction
      t.integer :seq
      t.integer :cluster
      
      t.timestamps
    end
  end
end
