class BlogPagesController < ApplicationController

  def home
    @carousel_rooms_first = Room.where(carousel: 'true').first
    @carousel_rooms_second = Room.where(carousel: 'true').second
    @carousel_rooms_last = Room.where(carousel: 'true').last
    @rooms = Room.where(hot: 'true')
    @microposts = Micropost.all.limit(3)
    @telechannels = Telechannel.last(3)
    @filterrific = initialize_filterrific(
       Room.all,
       params[:filterrific],
       select_options: {
        sorted_by: Room.options_for_sorted_by,
        with_room_cat_route: Room.cat_route_for_select,
        with_room_route: Room.route_for_select,
        with_room_city: Room.city_for_select,
        with_room_category: Room.category_for_select
       },
       persistence_id: "shared_key",
       default_filter_params: {
       },
       available_filters: [:sorted_by,
                           :search_query,
                           :with_room_cat_route,
                           :with_room_route,
                           :with_room_city,
                           :with_room_category],
       sanitize_params: true,
       ) || return

    @rooms = @filterrific.find

    @pagy, @rooms = pagy(@filterrific.find)

    respond_to do |format|
      format.html
    end

    rescue ActiveRecord::RecordNotFound => e
     # There is an issue with the persisted param_set. Reset it.
     puts "Had to reset filterrific params: #{e.message}"
     redirect_to(reset_filterrific_url(format: :html)) && return
  end

  def help
  end

  def about
  end

  def contact
  end

  def favorites
  end

  def group_message
    chat_id = -634155082
    text = "Hi all!"
    HTTParty.post("https://api.telegram.org/bot#{TELEGRAM}/sendMessage",
      headers: {
        'Content-type' => 'application/json'
      },
      body: {
        chat_id: chat_id,
        text: text
      }.to_json
    )
    redirect_to root_path, notice: 'Сообщение отправлено!'
  end

  def privat_message
    chat_id = 1961648829
    text = "Hi Andrew!"
    HTTParty.post("https://api.telegram.org/bot#{TELEGRAM}/sendMessage",
      headers: {
        'Content-type' => 'application/json'
      },
      body: {
        chat_id: chat_id,
        text: text
      }.to_json
    )
    redirect_to root_path, notice: 'Сообщение отправлено!'
  end

  def send_message
    text = params[:content]
    TelegramMailer.send_group_message(text).deliver_now
    redirect_to root_path, notice: 'Сообщение отправлено!'
  end
end
