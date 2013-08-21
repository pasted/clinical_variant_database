class CreateProteinSequenceVariants < ActiveRecord::Migration
  def change
    create_table :protein_sequence_variants do |t|
      t.integer :variant_id
      t.string :ensembl_protein_id
      t.integer :sequence_length
      t.string :strand
      t.string :codon_change
      t.integer :position
      t.string :residue_reference
      t.string :residue_alternative
      t.string :variant_type
      t.string :provean_score
      t.string :provean_prediction
      t.string :provean_seq
      t.string :provean_cluster
      t.string :sift_score
      t.string :sift_prediction
      t.string :sift_median_info
      t.string :sift_seq
      t.string :db_snp_id
      
      t.timestamps
    end
  end
end

