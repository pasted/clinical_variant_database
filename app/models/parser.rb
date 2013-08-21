class Parser
  
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Translation
  extend ActiveModel::Naming

  attr_accessor :headers, :sample_names, :variant_rows, :upload_id
  	  
  def initialize(params={})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params

      super()
  end
  
  def initialize
    self.headers = Array.new
    self.sample_names = Array.new
    self.variant_rows = Array.new
  end
  
  def persisted?
    return false  
  end

  def parse_sample_names(line)
    index_of_last_header = line.index("FORMAT")
    self.sample_names = line.chomp.split("\t").slice((index_of_last_header.to_i)..-1)
  end
  
  def parse_line(line)
    if line.index("#CHROM") == 0
      self.parse_sample_names(line) 
    elsif line.index("#") == 0
      self.headers.push(line)	  
    else
      new_variant_row = VariantRow.new
      new_variant_row.parse_row(line, self.sample_names, self.upload_id)
      self.variant_rows.push(new_variant_row)
    end
    return true
  end
  
  
end
