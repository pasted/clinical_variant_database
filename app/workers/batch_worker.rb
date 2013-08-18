class BatchWorker
  include Sidekiq::Worker
  include Biomart
  
  sidekiq_options :retry => 2, :backtrace => true
  
  sidekiq_retry_in do |count|
  	5 * (count + 1)
  end
  
  
  def perform(variant_set)
  	
  	s = Redis::Semaphore.new(:batch_worker_semaphore, connection: "localhost")
  	variant_set.each do |this_id|
    		if this_id
    			this_variant = Variant.find(this_id)
    			if !this_variant.find_gene
    			  this_gene = Gene.new
    			  response = this_gene.query_biomart(this_variant.location.chromosome.name, this_variant.location.position_start)
    			  unless s.locked?
    			  	s.lock(20)
    			  	this_gene.build_gene(response)
    			  	s.unlock
    			  end
    			end
    		end
    		
    end

  end

end
