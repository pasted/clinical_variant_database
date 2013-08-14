class Chromosome < ActiveRecord::Base
  attr_accessible :name

  has_many :locations, dependent: :destroy
  
end
