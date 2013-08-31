class Sample < ActiveRecord::Base
  	
  attr_accessible :quality_record_id, :subject_id, :genotype, :total_read_depth, :conditional_genotype_quality, :genotype_likelihood, :allele_read_depth
  
  belongs_to :quality_record
  belongs_to :subject
  

end
