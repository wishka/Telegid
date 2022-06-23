class TelechannelsController < ApplicationController
  before_action :set_telechannel, only: %i[ show edit update destroy ]

  # GET /telechannels or /telechannels.json
  def index
    @pagy, @telechannels = pagy(Telechannel.all)
  end

  # GET /telechannels/1 or /telechannels/1.json
  def show
    @telechannel = Telechannel.find(params[:id])
  end

  # GET /telechannels/new
  def new
    @telechannel = Telechannel.new
  end

  # GET /telechannels/1/edit
  def edit
    @telechannel = Telechannel.find(params[:id])
  end

  # POST /telechannels or /telechannels.json
  def create
    @telechannel = Telechannel.new(telechannel_params)

    respond_to do |format|
      if @telechannel.save
        format.html { redirect_to telechannel_url(@telechannel), notice: "Telechannel was successfully created." }
        format.json { render :show, status: :created, location: @telechannel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @telechannel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /telechannels/1 or /telechannels/1.json
  def update
    respond_to do |format|
      if @telechannel.update(telechannel_params)
        format.html { redirect_to telechannel_url(@telechannel), notice: "Telechannel was successfully updated." }
        format.json { render :show, status: :ok, location: @telechannel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @telechannel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /telechannels/1 or /telechannels/1.json
  def destroy
    @telechannel.destroy

    respond_to do |format|
      format.html { redirect_to telechannels_url, notice: "Telechannel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_telechannel
      @telechannel = Telechannel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def telechannel_params
      params.require(:telechannel).permit(:name, :content, :links, :image)
    end
end
