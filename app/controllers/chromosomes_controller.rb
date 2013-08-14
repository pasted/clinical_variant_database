class ChromosomesController < ApplicationController
  # GET /chromosomes
  # GET /chromosomes.json
  def index
    @chromosomes = Chromosome.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chromosomes }
    end
  end

  # GET /chromosomes/1
  # GET /chromosomes/1.json
  def show
    @chromosome = Chromosome.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chromosome }
    end
  end

  # GET /chromosomes/new
  # GET /chromosomes/new.json
  def new
    @chromosome = Chromosome.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chromosome }
    end
  end

  # GET /chromosomes/1/edit
  def edit
    @chromosome = Chromosome.find(params[:id])
  end

  # POST /chromosomes
  # POST /chromosomes.json
  def create
    @chromosome = Chromosome.new(params[:chromosome])

    respond_to do |format|
      if @chromosome.save
        format.html { redirect_to @chromosome, notice: 'Chromosome was successfully created.' }
        format.json { render json: @chromosome, status: :created, location: @chromosome }
      else
        format.html { render action: "new" }
        format.json { render json: @chromosome.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chromosomes/1
  # PUT /chromosomes/1.json
  def update
    @chromosome = Chromosome.find(params[:id])

    respond_to do |format|
      if @chromosome.update_attributes(params[:chromosome])
        format.html { redirect_to @chromosome, notice: 'Chromosome was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chromosome.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chromosomes/1
  # DELETE /chromosomes/1.json
  def destroy
    @chromosome = Chromosome.find(params[:id])
    @chromosome.destroy

    respond_to do |format|
      format.html { redirect_to chromosomes_url }
      format.json { head :no_content }
    end
  end
end
