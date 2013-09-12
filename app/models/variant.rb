class Variant < ActiveRecord::Base
  
  attr_accessible :name, :reference, :alternative

  has_one :location, :as => :locatable
  has_many :quality_records, dependent: :destroy

  has_many :protein_sequence_variants, dependent: :destroy
  
  before_destroy :delete_locatable
  

  def find_gene
    if (location = Location.found_in_gene(self.location.position_start).first)
      gene = location.locatable
      return gene
    else
    	return false
    end
  end
  
  def gene_name
    location = Location.found_in_gene(self.location.position_start).first
    if location && location.gene?
      gene = location.locatable
      return gene.external_gene_id
    end
  end
  
  def provean_variant
  	str = "#{self.location.chromosome.name},#{self.location.position_start},#{self.reference},#{self.alternative}"
  	return str
  end
  
  def self.query_provean(provean_variant, wait)
  	agent = Mechanize.new
  	start_page = agent.get("http://provean.jcvi.org/genome_submit.php")

  	this_form = start_page.form_with(:name => 'chrForm')
  	this_form.field_with(:name => "CHR").value = provean_variant

  	submit_page = agent.submit(this_form)


  		retryable(:tries => 3) do
  			sleep(wait)
  			next_page = agent.get(submit_page.uri.to_s)

  			job_id = submit_page.uri.to_s.split("http://provean.jcvi.org/genome_report.php?jobid=").last

  			tsv_file = agent.get("http://provean.jcvi.org/serve_file.php?VAR=g#{job_id}/#{job_id}.result.tsv")	
	
  			parsed_records = CSV.parse(tsv_file.body, {:col_sep => "\t", :headers => true})
  			return parsed_records
  		end
  	
  end
  
  def self.build_provean_records(parsed_records, id)
  	this_protein_variant = ProteinSequenceVariant.new
  	variant = Variant.find(id)
  	variant.protein_sequence_variants.clear
  	parsed_records.each do |row|
  		this_protein_variant.ensembl_protein_id 	= row[3]
  		this_protein_variant.sequence_length			= row[4]
  		this_protein_variant.strand								= row[5]
  		this_protein_variant.codon_change					= row[6]
  		this_protein_variant.position							= row[7]
  		this_protein_variant.residue_reference		= row[8]
  		this_protein_variant.residue_alternative  = row[9]
  		this_protein_variant.variant_type					= row[10]
  		this_protein_variant.provean_score				= row[11]
  		this_protein_variant.provean_prediction		= row[12]
  		this_protein_variant.provean_seq					= row[13]
  		this_protein_variant.provean_cluster			= row[14]
  		this_protein_variant.sift_score						= row[15]
  		this_protein_variant.sift_prediction			= row[16]
  		this_protein_variant.sift_median_info			= row[17]
  		this_protein_variant.sift_seq							= row[18]
  		this_protein_variant.db_snp_id						= row[19]
  		#for now clear any old protein variant records and replace

  	  variant.protein_sequence_variants.push(this_protein_variant)
  	end
  	variant.save!
  end
  
  protected
  
  def delete_locatable
  	if self.location
  			self.location.delete
  	end
  end 

  
end
