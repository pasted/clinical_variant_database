class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :chromosome_id
      t.string :strand
      t.integer :position_start
      t.integer :position_end
      t.references :locatable, polymorphic: true
      
      t.timestamps
    end
  end
end
