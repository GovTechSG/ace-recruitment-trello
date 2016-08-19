require_relative 'rtr'
require_relative 'telegram_bot'

class Job
  include Rtr
  include TelegramBot

  def initialize
    initialize_trello
    initialize_telegram_bot
  end

  def retrieve_idlers
    super
  end

  def to_message
    super
  end

  def send(message, recipient)
    super(message, recipient)
  end

  def recipients
    @recipients
  end
end
