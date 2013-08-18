class Prediction < ActiveRecord::Base
  attr_accessible :protein_sequence_variant_id, :score, :prediction, :seq, :cluster
 
  belongs_to :protein_sequence_variant
end
