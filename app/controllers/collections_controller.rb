class CollectionsController < ApplicationController
  before_action :authenticate_dairy!
  before_action :set_collection, only:[:destroy]
  def index
  	@collection = Collection.new
    params[:collection_date] = params[:collection_date] ? Date.parse(params[:collection_date]) : Date.today

  	@collections = current_dairy.collections.collection_at(params[:collection_date])
    
  	if params[:time] != 'true' && Time.now.hour > 12 
      @collections = @collections.evening
    else
      @collections = @collections.morning
    end

    @remaning_collections = current_dairy.users.where.not(id: @collections.collect(&:user_id))
  	gon.rates = current_dairy.rates.select(:fat, :snf, :degree, :rate, :animal_type)
    gon.current_collection = @collections.collect(&:user_id)
  end

   # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = current_dairy.collections.new(collection_params)
    respond_to do |format|
      if @collection.save

        format.html { redirect_to collections_path, notice: 'collection was successfully created.' }
        format.json { render json:{success: true, record: @collection, user: @collection.user} }
      else
        format.html { render :index }
        format.json { render json: {success: false, error: @collection.errors.full_messages.split(', ')} }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to collections_path, notice: 'collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'collection was successfully destroyed.' }
      format.json { render json:{ success: true, user_id: @collection.user_id } }
    end
  end

  private
    # collection callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = current_dairy.collections.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params[:collection][:collection_date] = Date.parse(params[:collection][:collection_date]) if params[:collection][:collection_date]
      params.require(:collection).permit(:snf, :fat, :degree, :rate, :animal_type, :litre, :time, :collection_date, :user_id)
    end
end
