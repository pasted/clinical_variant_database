class Sample < ActiveRecord::Base
  serialize :data, ActiveRecord::Coders::Hstore	
  attr_accessible :data, :name, :quality_id
  
  belongs_to :quality
  
  validates :name, presence: true
end
