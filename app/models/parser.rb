class Parser
  
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Translation
  extend ActiveModel::Naming

  attr_accessor :headers, :sample_names, :variant_records, :upload_id
  	  
  def initialize(params={})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params

      super()
  end
  
  def initialize
    self.headers = Array.new
    self.sample_names = Array.new
    self.variant_records = Array.new
  end
  
  def persisted?
    return false  
  end

  def parse_sample_names(line)
  	#split the header line on tabs, get the index of the string "FORMAT"
  	line_array = line.chomp.split("\t")
    index_of_last_header = line_array.index("FORMAT")
    start_index_of_names = index_of_last_header.to_i + 1
    
    #slice the line array from start of names to last element
    self.sample_names = line_array.slice((start_index_of_names)..-1)
  end
  
  def parse_line(line)
    if line.index("#CHROM") == 0
      self.parse_sample_names(line) 
    elsif line.index("#") == 0
      self.headers.push(line)
      if line.index("##INFO") == 0
      	fact_hash = Hash.new
      	this_substring = line.between_markers("<", ">")
      	substring_array = this_substring.split(",")
      	substring_array.each do |substr|
      	  case substr
      	  	when substr.include?("ID=")
      	  		substr_array = substr.split("ID=")
      	  		fact_hash["name"] = substr_array[1]
      	  	when substr.include?("Number=")
      	  		substr_array = substr.split("Number=")
      	  		fact_hash["number"] = substr_array[1]
      	  	when substr.include?("Type=")
      	  		substr_array = substr.split("Type=")
      	  		fact_hash["type"] = substr_array[1]
      	  	when substr.include?("Description=")
      	  		substr_array = substr.split("Description=")
      	  		fact_hash["description"] = substr_array[1]
      	  end
        end
        
        if !Fact.find_by_name(fact_hash["name"])
        	new_fact = Fact.new(fact_hash)
        	new_fact.save!
        end
      end
    else
      new_variant_record = VariantRecord.new
      new_variant_record.parse_row(line, self.sample_names, self.upload_id)
      self.variant_records.push(new_variant_record)
    end
    return true
  end
  
  
end
