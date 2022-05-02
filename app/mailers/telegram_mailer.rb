class TelegramMailer < ApplicationMailer
  def send_group_message(text)
    chat_id = -634155082
    #text = "Hi all!"
    HTTParty.post("https://api.telegram.org/bot#{TELEGRAM}/sendMessage",
      headers: {
        'Content-type' => 'application/json'
      },
      body: {
        chat_id: chat_id,
        text: text
      }.to_json
    )
  end
end
