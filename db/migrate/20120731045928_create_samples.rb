class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
    	t.integer :quality_record_id
      t.string :name
      t.hstore :data

      t.timestamps
    end
  end
end
