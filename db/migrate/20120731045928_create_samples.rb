class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
    	t.integer :quality_record_id
      t.integer :subject_id
      t.string :genotype
      t.string :total_read_depth
      t.string :conditional_genotype_quality
      t.string :genotype_likelihood
      t.string :allele_read_depth

      t.timestamps
    end
  end
end
