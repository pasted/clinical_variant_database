class VariantRow

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Translation
  extend ActiveModel::Naming

  attr_accessor :chrom, :pos, :variant_name, :ref, :alt, :qual, :filter, :info, :format, :samples, :sample_keys
  	  
  def initialize(params={})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params

      super()
  end
  
  def initialize
    self.sample_keys = Array.new
    self.samples = Hash.new
  end
  
  def persisted?
  	  return false  
  end
  
  def parse_info(element)
    self.info = Hash.new
    info_array = element.split(";")
    info_array.each do |this_info|
      hash_pair_array = this_info.split("=", -1)    
      if hash_pair_array.size == 2
        self.info[hash_pair_array[0]] = hash_pair_array[1]	
      else
      	self.info["Unknown"] = hash_pair_array.inspect      
      end
    end
  end
  
  def parse_samples(line_array, sample_names)
    sample_names.each_with_index do |this_name, this_index|
      sample_index = this_index + 9
      sample_values = line_array[sample_index].split(":")
      self.samples[this_name] = Hash.new

      self.sample_keys.each_with_index do |this_key, this_key_index|
      	      self.samples[this_name][this_key] = sample_values[this_key_index] || ""	      
      end
      
    end
  end

  def build_records(upload_id)
   
    this_chromosome = Chromosome.find_by_name(self.chrom)
    this_upload = Upload.find(upload_id)
    if (found_location = Location.find_by_position_start(self.pos.to_i)) && (found_location.locatable_type == "Variant")
      this_variant = found_location.locatable
    else
      this_variant = Variant.new
      this_variant.name = self.variant_name
      this_variant.reference = self.ref
      this_variant.alternative = self.alt
      
      this_location = Location.new
      this_location.chromosome = this_chromosome
      this_location.position_start = self.pos.to_i
      this_location.position_end = self.pos.to_i
      this_location.strand = "+"
    end
    
    this_quality_record = QualityRecord.new
    this_quality_record.score = self.qual
    this_quality_record.filter = self.filter
    
    
    self.samples.each do |sample_name, sample_data|
      this_sample = Sample.new
      this_sample.name = sample_name
      this_sample.data = sample_data
      if this_sample.valid?
        this_quality_record.samples.push(this_sample)   
      end
    end
    
    this_upload.quality_records.push(this_quality_record)
    this_variant.quality_records.push(this_quality_record)
    this_variant.location = this_location
    
    this_upload.save!
    this_variant.save!
  end
  
  def parse_row(line, sample_names, upload_id)
      line_array = line.chomp.split("\t")
      self.chrom = line_array[0].chomp.upcase
      self.pos = line_array[1].chomp
      self.variant_name = line_array[2].chomp
      self.ref = line_array[3].chomp
      self.alt = line_array[4].chomp
      self.qual = line_array[5].chomp
      self.filter = line_array[6].chomp

      self.parse_info(line_array[7].chomp)
      self.format = line_array[8].chomp
      self.sample_keys = self.format.split(":")

      self.parse_samples(line_array, sample_names)
      self.build_records(upload_id)
  end
  

  
end
