class Location < ActiveRecord::Base
  attr_accessible :chromosome_id, :position_start, :position_end

  
  belongs_to :locatable, polymorphic: true
  belongs_to :chromosome, dependent: :destroy 
  
  def self.includes_location(location)
    where("position_start <= ? AND position_end >= ?", location, location)  
  end
  
  def self.includes_gene_location(location)
    where("position_start <= ? AND position_end >= ? AND locatable_type = ?", location, location, "Gene") 
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
