class CreateDisordersAndGenes < ActiveRecord::Migration
  def change
  	create_table :disorders do |t|
    	t.string :omim_id
    	t.string :disorder_omim_id
    	t.string :name
    	t.string :disorder_type
    	
    	t.timestamps
    end
    
    create_table :genes do |t|
      t.string :external_gene_id
      t.string :ensembl_gene_id
      t.string :hgnc_id
      t.integer :transcript_count

      t.timestamps
    end
    
    create_table :disorders_genes do |t|
    	t.belongs_to :gene
    	t.belongs_to :disorder
    end
    
  end
end
