class ProteinSequenceVariant < ActiveRecord::Base
  
  attr_accessible :variant_id, :ensembl_protein_id, :length, :strand, :codon_change, :position, :residue_reference, :residue_alternative, :variant_type 

  has_many :predictions
  belongs_to  :variant, dependent: :destroy

end
