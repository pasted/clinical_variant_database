class Variant < ActiveRecord::Base
  
  attr_accessible :name, :reference, :alternative

  has_one :location, :as => :locatable
  has_many :quality_records, dependent: :destroy
  has_many :protein_sequence_variants, dependent: :destroy

  def find_gene
    if (location = Location.includes_location(self.location.position_start).first) && (location.gene?)
      @gene = location.locatable
      return @gene
    else
    	return false
    end
  end
  
  def gene_name
    location = Location.includes_gene_location("#{self.location.position_start}").first
    if location && location.gene?
      @gene = location.locatable
      return @gene.external_gene_id
    end
  end
  
  def provean_variant
  	str = "#{self.location.chromosome.name},#{self.location.position_start},#{self.reference},#{self.alternative}"
  	return str
  end
  
  def query_provean
  	agent = Mechanize.new
  	start_page = agent.get("http://provean.jcvi.org/genome_submit.php")

  	this_form = start_page.form_with(:name => 'chrForm')
  	this_form.field_with(:name => "CHR").value = self.provean_variant

  	submit_page = agent.submit(this_form)


  		retryable(:tries => 3) do
  			sleep(10)
  			next_page = agent.get(submit_page.uri.to_s)

  			job_id = submit_page.uri.to_s.split("http://provean.jcvi.org/genome_report.php?jobid=").last

  			tsv_file = agent.get("http://provean.jcvi.org/serve_file.php?VAR=g#{job_id}/#{job_id}.result.tsv")	
	
  			parsed_records = CSV.parse(tsv_file.body, {:col_sep => "\t", :headers => true})
  			return parsed_records
  		end
  	
  end
  
  def build_provean_records(parsed_records)
  	this_protein_variant = ProteinSequenceVariant.new
  	parsed_records.each do |row|
  		this_protein_variant.ensembl_protein_id 	= row["PROTEIN_ID"]
  		this_protein_variant.sequence_length								= row["LENGTH"]
  		this_protein_variant.strand								= row["STRAND"]
  		this_protein_variant.codon_change					= row["CODON_CHANGE"]
  		this_protein_variant.position							= row["POS"]
  		this_protein_variant.residue_reference		= row["RESIDUE_REF"]
  		this_protein_variant.residue_alternative  = row["RESIDUE_ALT"]
  		this_protein_variant.variant_type					= row["TYPE"]
  	  self.protein_sequence_variants.push(this_protein_variant)
  	end
  	self.save!
  end
  
end
