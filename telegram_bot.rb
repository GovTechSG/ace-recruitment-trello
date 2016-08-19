require 'telegram/bot'

module TelegramBot
  def initialize_telegram_bot
    @token = ENV['BGP_REC_TELEGRAM_TOKEN']
    @recipients = ENV['BGP_REC_RECIPIENTS'].split('|')
  end

  def send(message, recipient)
    Telegram::Bot::Client.run(@token) do |bot|
      bot.api.send_message(chat_id: recipient, text: message)
      break
    end
  end
end
