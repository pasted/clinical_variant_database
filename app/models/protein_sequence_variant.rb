class ProteinSequenceVariant < ActiveRecord::Base
  
  attr_accessible :variant_id, :ensembl_protein_id, :length, :strand, :codon_change, :position, :residue_reference, :residue_alternative, :variant_type 
  attr_accessible :provean_score, :provean_prediction, :provean_seq, :provean_cluster
  attr_accessible :sift_score, :sift_prediction, :sift_median_info, :sift_seq
  attr_accessible :db_snp_id

  belongs_to  :variant

end
