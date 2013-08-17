class BatchWorker
  include Sidekiq::Worker
  include Biomart
  
  sidekiq_options :queue => :biomart_query, :retry => 2, :backtrace => true
  
  sidekiq_retry_in do |count|
  	5 * (count + 1)
  end
  
  
  def perform(variant_id)
    this_variant = Variant.find(variant_id)
    this_location = this_variant.location
    this_gene = Gene.new
    response = this_gene.query_biomart(this_location.chromosome.name, this_location.position_start)
    this_gene.build_gene(response)

  end

end
