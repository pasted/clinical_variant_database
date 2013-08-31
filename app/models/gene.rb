class Gene < ActiveRecord::Base
  include Biomart
  attr_accessible :external_gene_id, :ensembl_gene_id, :hgnc_id, :transcript_count
  
  has_many :locations, :as => :locatable
  has_and_belongs_to_many :disorders
  
  before_destroy :delete_disorders
  before_destroy :delete_locatable
  
  def find_variants
  	variants = Array.new
  	locations = Location.includes_variant_location(self.locations.first.position_start, self.locations.first.position_end)
  	locations.each do |location|
  		variants.push( location.locatable )
  	end
  	return variants
  end
  
  def convert_strand_string(strand)
  	  if strand == "-1"
  	    return "-"
  	  elsif strand == "1"
  	    return "+"
  	  end
  end
  
  def query_biomart(chromosome_name, start_position)
    biomart = Biomart::Server.new("http://www.biomart.org/biomart")
    ensembl = biomart.datasets["hsapiens_gene_ensembl"]
    
    response = ensembl.search(:filters => {"chromosome_name" => chromosome_name, "start" => start_position.to_i, "end" => start_position.to_i+1, "status" => "KNOWN"},
    	:attributes => ["external_gene_id", "ensembl_gene_id", "hgnc_id","chromosome_name", "strand", "start_position", "end_position", "transcript_count"])
    return response
  end
  
  def build_gene(response)
    if ((response) && !(Gene.find_by_ensembl_gene_id(response[:data][0][1])))
      self.external_gene_id = response[:data][0][0]
      self.ensembl_gene_id  = response[:data][0][1]
      self.hgnc_id					= response[:data][0][2]
      self.transcript_count = response[:data][0][7]
      
      this_chromosome = Chromosome.find_by_name(response[:data][0][3])
      
      this_location = Location.new
      this_location.strand	     = convert_strand_string(response[:data][0][4])
      this_location.position_start   = response[:data][0][5]
      this_location.position_end     = response[:data][0][6]
      this_location.chromosome = this_chromosome
      
      self.locations.push(this_location)
      if !(Gene.find_by_ensembl_gene_id(self.ensembl_gene_id))
      	self.save!
      	self.reload
      	this_disorder = Disorder.new
        disorder_response = this_disorder.query_biomart(self.external_gene_id)
        if ((disorder_response) && !(Disorder.find_by_omim_id(response[:data][0][0])))
      	  this_disorder.build_disorder(disorder_response, self.id)
        end
        self.save!
      end

    end
  end
  
  def self.remove_duplicates 
    grouped = all.group_by{|model| [model.ensembl_gene_id] }
    grouped.values.each do |duplicates|
      first_one = duplicates.shift 
      duplicates.each{|leftover| leftover.destroy} 
    end
  end

  protected
  
  def delete_locatable
  	if self.locations.length > 0
  		self.locations.delete_all
  	end
  end
  
  def delete_disorders
  	if self.disorders.length > 0
  		self.disorders.delete_all
  	end
  end
  
end
