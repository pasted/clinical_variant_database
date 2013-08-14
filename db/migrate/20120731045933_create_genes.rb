class CreateGenes < ActiveRecord::Migration
  def change
    create_table :genes do |t|
      t.string :external_gene_id
      t.string :ensembl_gene_id
      t.integer :transcript_count

      t.timestamps
    end
  end
end
