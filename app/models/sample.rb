class Sample < ActiveRecord::Base
  serialize :data, ActiveRecord::Coders::Hstore	
  attr_accessible :quality_record_id, :data, :name, :quality_id
  
  belongs_to :quality_record
  
  validates :name, presence: true
  
  #Based on http://railscasts.com/episodes/345-hstore?view=asciicast
  %w[AD PL GT GQ DP].each do |key|
    attr_accessible key
    scope "has_#{key}", lambda { |value| where("data @> (? => ?)", key, value) }
    
    define_method(key) do
      properties && properties[key]
    end
    
    define_method("#{key}=") do |value|
      self.properties = (properties || {}).merge(key => value)
    end
  end
end
