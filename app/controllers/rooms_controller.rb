class RoomsController < ApplicationController

  before_action :set_room, only: %i[ show edit update destroy ]


  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @rooms = Room.all
    render 'index'
    if @room = Room.find(params[:id])
    else
      render 'new'
    end
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    @room.customer_id = current_customer.id
    if @room.save
      redirect_to request.referrer

      SendMessageJob.perform_later(@room)

      text = "Новое объявление: #{@room.name}"
      TelegramMailer.send_group_message(text).deliver_now
    else
      render 'new'
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
        text = "Объявление изменено: #{@room.name}"
        TelegramMailer.send_group_message(text).deliver_now
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
      text = "Объявление удалено: #{@room.name}"
      TelegramMailer.send_group_message(text).deliver_now
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :content, :route, :cat_route, :subdir, :category, :image, :city, :option)
    end
end
