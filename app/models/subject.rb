class Subject < ActiveRecord::Base

  attr_accessible :name
  
  has_many :samples 
  has_many :quality_records, :through => :samples
  has_many :variants, :through => :quality_records
  
end
