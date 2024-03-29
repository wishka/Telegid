class BlogPagesController < ApplicationController

  def home
    @carousel_rooms_first = Room.where(carousel: 'true').first
    @carousel_rooms_second = Room.where(carousel: 'true').second
    @carousel_rooms_last = Room.where(carousel: 'true').last
    @microposts = Micropost.all.limit(3)
    @telechannels = Telechannel.last(3)
    @pagy, @rooms = pagy(Room.where(hot: 'true'))
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
