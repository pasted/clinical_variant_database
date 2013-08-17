class DisordersController < ApplicationController
  # GET /disorders
  # GET /disorders.json
  def index

    if !params[:q]
      params[:q] = {:order => "descend_by_id"}	
    end
    
    @search = Disorder.search(params[:q])   
    @disorders = @search.result.page(params[:page]).per(20)
    @search.build_condition

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @disorders }
    end
  end

  # GET /disorders/1
  # GET /disorders/1.json
  def show
    @disorder = Disorder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @disorder }
    end
  end

  # GET /disorders/new
  # GET /disorders/new.json
  def new
    @disorder = Disorder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @disorder }
    end
  end

  # GET /disorders/1/edit
  def edit
    @disorder = Disorder.find(params[:id])
  end

  # POST /disorders
  # POST /disorders.json
  def create
    @disorder = Disorder.new(params[:disorder])

    respond_to do |format|
      if @disorder.save
        format.html { redirect_to @disorder, notice: 'Disorder was successfully created.' }
        format.json { render json: @disorder, status: :created, location: @disorder }
      else
        format.html { render action: "new" }
        format.json { render json: @disorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /disorders/1
  # PUT /disorders/1.json
  def update
    @disorder = Disorder.find(params[:id])

    respond_to do |format|
      if @disorder.update_attributes(params[:disorder])
        format.html { redirect_to @disorder, notice: 'Disorder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @disorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disorders/1
  # DELETE /disorders/1.json
  def destroy
    @disorder = Disorder.find(params[:id])
    @disorder.destroy

    respond_to do |format|
      format.html { redirect_to disorders_url }
      format.json { head :no_content }
    end
  end

end
