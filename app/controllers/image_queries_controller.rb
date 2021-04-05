class ImageQueriesController < ApplicationController
  before_action :set_image_query, only: %i[ analyze_query show edit update destroy ]

  # GET /image_queries or /image_queries.json
  def index
    @image_queries = ImageQuery.all.with_attached_image
  end

  # GET /image_queries/1 or /image_queries/1.json
  def show
  end

  # GET /image_queries/new
  def new
    @image_query = ImageQuery.new
  end

  # GET /image_queries/1/edit
  def edit
  end

  def analyze_query
    result = ImageQueriesHelper::QueryImages.new(@image_query).run

    respond_to do |format|
      if result
        format.html { redirect_to @image_query, notice: "Image query results are in!" }
        format.json { render :show, status: :created, location: @image_query }
      else
        format.html { redirect_to @image_query, notice: "Could not process query. Try again." }
        format.json { render :show, status: :unprocessable_entity, location: @image_query }
      end
    end
  end

  # POST /image_queries or /image_queries.json
  def create
    @image_query = ImageQuery.new(image_query_params)

    respond_to do |format|
      if @image_query.save
        format.html { redirect_to @image_query, notice: "Image query was successfully created." }
        format.json { render :show, status: :created, location: @image_query }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image_query.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_queries/1 or /image_queries/1.json
  def update
    respond_to do |format|
      if @image_query.update(image_query_params)
        format.html { redirect_to @image_query, notice: "Image query was successfully updated." }
        format.json { render :show, status: :ok, location: @image_query }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image_query.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_queries/1 or /image_queries/1.json
  def destroy
    @image_query.destroy
    respond_to do |format|
      format.html { redirect_to image_queries_url, notice: "Image query was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_query
      @image_query = ImageQuery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_query_params
      params.require(:image_query).permit(:name, :person_id, :is_match, :percentage_match, :image, :meta)
    end
end
