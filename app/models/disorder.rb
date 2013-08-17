class Disorder < ActiveRecord::Base
  include Biomart
  attr_accessible :omim_id, :disorder_omim_id, :name, :disorder_type

  has_and_belongs_to_many :genes

  def query_biomart(gene_symbol)
    biomart = Biomart::Server.new("http://www.biomart.org/biomart")
    omim = biomart.datasets["omim"]
    
    response = omim.search(:filters => {"human_gene_symbol" => gene_symbol},
    	:attributes => ["omim_id", "disorder_omim_id", "disorder_name", "disorder_type", "human_gene_symbol"])

    return response
  end
  
  def build_disorder(response, gene_id)
    if response
      self.omim_id = response[:data][0][0]
      self.disorder_omim_id  = response[:data][0][1]
      self.name = response[:data][0][2]
      self.disorder_type = response[:data][0][3]
      
      this_gene = Gene.find(gene_id)
      self.genes.push(this_gene)
      self.save!
    end
  end
end
