class GenesController < ApplicationController
  # GET /genes
  # GET /genes.json
  def index

    if !params[:q]
      params[:q] = {:order => "descend_by_id"}	
    end
    
    @search = Gene.search(params[:q])   
    @genes = @search.result.page(params[:page]).per(20)
    @search.build_condition

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @genes }
    end
  end

  # GET /genes/1
  # GET /genes/1.json
  def show
    @gene = Gene.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gene }
    end
  end

  # GET /genes/new
  # GET /genes/new.json
  def new
    @gene = Gene.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gene }
    end
  end

  # GET /genes/1/edit
  def edit
    @gene = Gene.find(params[:id])
  end

  # POST /genes
  # POST /genes.json
  def create
    @gene = Gene.new(params[:gene])

    respond_to do |format|
      if @gene.save
        format.html { redirect_to @gene, notice: 'Gene was successfully created.' }
        format.json { render json: @gene, status: :created, location: @gene }
      else
        format.html { render action: "new" }
        format.json { render json: @gene.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /genes/1
  # PUT /genes/1.json
  def update
    @gene = Gene.find(params[:id])

    respond_to do |format|
      if @gene.update_attributes(params[:gene])
        format.html { redirect_to @gene, notice: 'Gene was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gene.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genes/1
  # DELETE /genes/1.json
  def destroy
    @gene = Gene.find(params[:id])
    @gene.destroy

    respond_to do |format|
      format.html { redirect_to genes_url }
      format.json { head :no_content }
    end
  end

  def query_biomart
    @variants = Variant.all  
    @variants.each do |variant|
      if variant.location.position_start
      	if !((location = Location.includes_location(variant.location.position_start).first ) && ( location.gene?)) 
      	      this_gene = Gene.new
      	      this_response = this_gene.query_biomart(variant.location.chromosome.name, variant.location.position_start)
      	      this_gene.build_gene(this_response)
        end
      end
    end
    respond_to do |format|
      format.html 
      format.json { render json: @genes }
    end
  end
  
end
