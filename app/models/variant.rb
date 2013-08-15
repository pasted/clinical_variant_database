class Variant < ActiveRecord::Base
  attr_accessible :name, :reference, :alternative

  has_one :location, :as => :locatable
  has_many :quality_records, dependent: :destroy

  def find_gene
    if (location = Location.includes_location(self.location.position_start).first) && (location.gene?)
      @gene = location.locatable
      return @gene
    else
    	return false
    end
  end
  
  def gene_name
    location = Location.includes_gene_location("#{self.location.position_start}").first
    if location && location.gene?
      @gene = location.locatable
      return @gene.external_gene_id
    end
  end
end
