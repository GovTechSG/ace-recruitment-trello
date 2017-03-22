require 'trello'

module Rtr # stands for Recrutiment Trello Ruby
  def initialize_trello
    Trello.configure do |config|
      config.developer_public_key = ENV['BGP_REC_TRELLO_KEY']
      config.member_token = ENV['BGP_REC_TRELLO_TOKEN']
    end
  end

  def retrieve_idlers
    board_id = ENV['BOARD_ID']
    list_exceptions = ENV['LIST_EXCEPTIONS'].split('|')
    card_exceptions = ENV['CARD_EXCEPTIONS'].split('|')
    @week_idlers = []
    Trello::Board.find(board_id).lists.each do |list|
      next if list_exceptions.include? list.id
      list.cards.each do |c|
        next if card_exceptions.include? c.id
        time_diff = Time.now - c.last_activity_date
        card_info = {
          name: c.name,
          last_activity_date: c.last_activity_date,
          url: c.short_url,
          list_name: list.name
        }

        @week_idlers.push(card_info) if (time_diff / 1.week).floor >= 1
      end
    end
    @week_idlers.sort! do |a, b|
      a[:last_activity_date] <=> b[:last_activity_date]
    end

    @to_message_case = 'retrieve_idlers'
    self
  end

  # Base @to_message_case, formats the message to be readable
  def to_message
    message = ''

    case @to_message_case
    when 'retrieve_idlers'
      if @week_idlers.empty?
        message += 'There are no idlers.'
      else
        unless @week_idlers.empty?
          message += "There are #{@week_idlers.length} idling for at least a week: \n"
          @week_idlers.each do |i|
            message += idler_line_message(i)
          end
        end
      end
    end

    message
  end

  private

  def time_ago_in_words(t1, t2)
    s = t1.to_i - t2.to_i # distance between t1 and t2 in seconds

    resolution = if s > 29030400
      [(s/29030400), 'years']
    elsif s > 2419200
      [(s/2419200), 'months']
    elsif s > 604800
      [(s/604800), 'weeks']
    end

    if resolution[0] == 1
      resolution.join(' ')[0...-1]
    else
      resolution.join(' ')
    end
  end

  def emoji(t1, t2)
    s = t1.to_i - t2.to_i # distance between t1 and t2 in seconds

    if s > 4838400
      '‼️'
    elsif s > 2419200
      '❗'
    elsif s > 604800
      '❕'
    end
  end

  def idler_line_message(i)
    "#{emoji(Time.now, i[:last_activity_date])} " \
    "#{i[:name]}(#{i[:list_name]}), " \
    "#{time_ago_in_words(Time.now, i[:last_activity_date])} ago\n↳ #{i[:url]}\n\n"
  end
end
