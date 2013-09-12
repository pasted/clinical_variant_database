class Location < ActiveRecord::Base
  attr_accessible :chromosome_id, :position_start, :position_end

  validates :chromosome_id, :presence => {:message => "is not valid, Location not saved."}
  validates :position_start, :presence => {:message => "is not valid, Location not saved."}
  validates :position_end, :presence => {:message => "is not valid, Location not saved."}
  
  belongs_to :locatable, polymorphic: true
  belongs_to :chromosome
  
  def self.includes_location(location)
    where("position_start <= ? AND position_end >= ?", location, location)  
  end
  
  def self.includes_gene_location(location_start, location_end)
    where("position_start >= ? AND position_end <= ? AND locatable_type = ?", location_start, location_end, "Gene") 
  end
  
  def self.includes_variant_location(location_start, location_end)
  	where("position_start >= ? AND position_end <= ? AND locatable_type = ?", location_start, location_end , "Variant")
  end
  
  def self.includes_feature_location(location_start, location_end, feature_type)
  	where("position_start >= ? AND position_end <= ? AND locatable_type = ?", location_start, location_end, feature_type)
  end
  
  def self.found_in_gene(location_start)
  	where("position_start <= ? AND position_end >= ? AND locatable_type = ?", location_start, location_start, "Gene") 
  end
  
  def self.variants
  	where("locatable_type = ?", "Variant")
  end
  
  def self.genes
  	where("locatable_type = ?", "Gene")
  end
  
  def self.variants_by_chromosome(chromosome)
  	where("chromosome_id = ?  AND locatable_type = ?", chromosome, "Variant")
  end
  
  def self.genes_by_chromosome(chromosome)
  	where("chromosome_id = ?  AND locatable_type = ?", chromosome, "Gene")
  end

  def variant?
    if self.locatable_type == "Variant"
      return true
    else
      return false
    end
  end
  
  def gene?
    if self.locatable_type == "Gene"
      return true
    else
      return false
    end
  end
end
