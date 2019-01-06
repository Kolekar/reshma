class RatesController < ApplicationController
  before_action :authenticate_dairy!
  before_action :set_rate, only: [:edit, :update, :destroy]

  # GET /rates
  # GET /rates.json
  def index
    @rates = current_dairy.rates.all
  end

  # GET /rates/new
  def new
    @rate = Rate.new
  end

  # GET /rates/1/edit
  def edit
  end

  # POST /rates
  # POST /rates.json
  def create
    @rate = current_dairy.rates.new(rate_params)
    respond_to do |format|
      if @rate.save
        format.html { redirect_to new_rate_path, notice: 'rate was successfully created.' }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html { render :new }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rates/1
  # PATCH/PUT /rates/1.json
  def update
    respond_to do |format|
      if @rate.update(rate_params)
        format.html { redirect_to rates_path, notice: 'rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1
  # DELETE /rates/1.json
  def destroy
    @rate.destroy
    respond_to do |format|
      format.html { redirect_to rates_url, notice: 'rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # rate callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = current_dairy.rates.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_params
      params.require(:rate).permit(:snf, :fat, :degree, :rate, :animal_type)
    end
end
