class ProveanBatchWorker
  include Sidekiq::Worker
  
  sidekiq_options :queue => :provean_batch_worker, :retry => 2, :backtrace => true
  
  sidekiq_retry_in do |count|
  	5 * (count + 1)
  end
  
  
  def perform(variant_set)
  	

  	variant_set.each do |this_id|
    		if this_id
    			this_variant = Variant.find(this_id)
    			provean_variants << this_variant.provean_variant << "\n"
    		end	
    end
    
    parsed_records = Variant.query_provean(provean_variants, 60)
    
    unless s.locked?
    	s.lock(10)
    		Variant.build_provean_records(parsed_records)
    	s.unlock
    end

  end

end
