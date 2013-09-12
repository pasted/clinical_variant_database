class QualityRecord < ActiveRecord::Base
  attr_accessible :variant_id, :upload_id, :score, :filter

  belongs_to :variant
  belongs_to :upload
  has_many :samples, dependent: :destroy
  has_many :subjects, :through => :samples

end
