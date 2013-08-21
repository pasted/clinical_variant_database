class ProteinSequenceVariantsController < ApplicationController
  # GET /protein_sequence_variants
  # GET /protein_sequence_variants.json
  def index
    
    @search = ProteinSequenceVariant.search(params[:q])   
    @protein_sequence_variants = @search.result.page(params[:page]).per(20)
    @search.build_condition
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @protein_sequence_variants }
    end
  end

  # GET /protein_sequence_variants/1
  # GET /protein_sequence_variants/1.json
  def show
    @protein_sequence_variant = ProteinSequenceVariant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @protein_sequence_variant }
    end
  end

  # GET /protein_sequence_variants/new
  # GET /protein_sequence_variants/new.json
  def new
    @protein_sequence_variant = ProteinSequenceVariant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @protein_sequence_variant }
    end
  end

  # GET /protein_sequence_variants/1/edit
  def edit
    @protein_sequence_variant = ProteinSequenceVariant.find(params[:id])
  end

  # POST /protein_sequence_variants
  # POST /protein_sequence_variants.json
  def create
    @protein_sequence_variant = ProteinSequenceVariant.new(params[:protein_sequence_variant])

    respond_to do |format|
      if @protein_sequence_variant.save
        format.html { redirect_to @protein_sequence_variant, notice: 'ProteinSequenceVariant was successfully created.' }
        format.json { render json: @protein_sequence_variant, status: :created, location: @protein_sequence_variant }
      else
        format.html { render action: "new" }
        format.json { render json: @protein_sequence_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /protein_sequence_variants/1
  # PUT /protein_sequence_variants/1.json
  def update
    @protein_sequence_variant = ProteinSequenceVariant.find(params[:id])

    respond_to do |format|
      if @protein_sequence_variant.update_attributes(params[:protein_sequence_variant])
        format.html { redirect_to @protein_sequence_variant, notice: 'ProteinSequenceVariant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @protein_sequence_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /protein_sequence_variants/1
  # DELETE /protein_sequence_variants/1.json
  def destroy
    @protein_sequence_variant = ProteinSequenceVariant.find(params[:id])
    @protein_sequence_variant.destroy

    respond_to do |format|
      format.html { redirect_to protein_sequence_variants_url }
      format.json { head :no_content }
    end
  end
end
