class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    source = 'http://developer.itsmarta.com/BRDRestService/BRDRestService.svc/GetAllBus'
    @buses = fetch_url_data(source)

    @message = ""

    @buses.each do |bus|
      if nearby(@location.longitude, @location.latitude, bus["LONGITUDE"].to_f, bus["LATITUDE"].to_f)
        @message = "A bus is nearby!"
      else
        @message = "Sorry, it's gonna be a while, buddy."
      end
    end
  end


  def fetch_url_data(source)
    http = Net::HTTP.get_response(URI.parse(source))
    data = http.body
    response = JSON.parse(data)
    return response
  end

  def nearby(lng1, lat1, lng2, lat2)
    if (lng1 - lng2).abs <= 0.01 && (lat1 - lat2).abs <= 0.01
      return true
    else
      return false
    end
  end


  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:full_street_address, :latitude, :longitude)
    end
end
