class CreateQualityRecords < ActiveRecord::Migration
  def change
      create_table :quality_records do |t|
      t.integer "variant_id"
      t.integer "upload_id"
      t.string  "score"
      t.string  "filter"

      t.timestamps
    end
  end
end
