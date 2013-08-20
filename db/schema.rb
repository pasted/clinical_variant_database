# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120731045936) do

  create_table "chromosomes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "disorders", :force => true do |t|
    t.string   "omim_id"
    t.string   "disorder_omim_id"
    t.string   "name"
    t.string   "disorder_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "disorders_genes", :force => true do |t|
    t.integer "gene_id"
    t.integer "disorder_id"
  end

  create_table "genes", :force => true do |t|
    t.string   "external_gene_id"
    t.string   "ensembl_gene_id"
    t.string   "hgnc_id"
    t.integer  "transcript_count"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "locations", :force => true do |t|
    t.integer  "chromosome_id"
    t.string   "strand"
    t.integer  "position_start"
    t.integer  "position_end"
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "predictions", :force => true do |t|
    t.integer  "protein_sequence_variant_id"
    t.integer  "score"
    t.string   "prediction"
    t.integer  "seq"
    t.integer  "cluster"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "protein_sequence_variants", :force => true do |t|
    t.integer  "variant_id"
    t.string   "ensembl_protein_id"
    t.integer  "sequence_length"
    t.string   "strand"
    t.string   "codon_change"
    t.integer  "position"
    t.string   "residue_reference"
    t.string   "residue_alternative"
    t.string   "variant_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "quality_records", :force => true do |t|
    t.integer  "variant_id"
    t.integer  "upload_id"
    t.string   "score"
    t.string   "filter"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "samples", :force => true do |t|
    t.integer  "quality_record_id"
    t.string   "name"
    t.hstore   "data"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "uploads", :force => true do |t|
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "variants", :force => true do |t|
    t.string   "name"
    t.string   "reference"
    t.string   "alternative"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
