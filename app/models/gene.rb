class Gene < ActiveRecord::Base
  include Biomart
  attr_accessible :external_gene_id, :ensembl_gene_id, :transcript_count

  has_many :locations, :as => :locatable

    
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
	:attributes => ["external_gene_id", "ensembl_gene_id", "chromosome_name", "strand", "start_position", "end_position", "transcript_count"])
    return response
  end
  
  def build_gene(response)
    if response
      this_gene = Gene.new
      this_gene.external_gene_id = response[:data][0][0]
      this_gene.ensembl_gene_id  = response[:data][0][1]
      this_gene.transcript_count = response[:data][0][6]
      
      this_chromosome = Chromosome.find_by_name(response[:data][0][2])
      
      this_location = Location.new
      this_location.strand	     = convert_strand_string(response[:data][0][3])
      this_location.position_start   = response[:data][0][4]
      this_location.position_end     = response[:data][0][5]
      this_location.chromosome = this_chromosome
      
      this_gene.locations.push(this_location)
      this_gene.save!
    end
  end
end
