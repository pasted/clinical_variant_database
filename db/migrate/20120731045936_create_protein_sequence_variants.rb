class CreateProteinSequenceVariants < ActiveRecord::Migration
  def change
    create_table :protein_sequence_variants do |t|
      t.integer :variant_id
      t.string :ensembl_protein_id
      t.integer :length
      t.string :strand
      t.string :codon_change
      t.integer :position
      t.string :residue_reference
      t.string :residue_alternative
      t.string :variant_type
      
      t.timestamps
    end
  end
end
