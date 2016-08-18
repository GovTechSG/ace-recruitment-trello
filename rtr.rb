require 'trello'

# board = Trello::Board.find("0qxDagQl")
# board.lists.each do |l|
#   p l.name, l.id
# end
# "Inbox-UX Candidates", "54d84857f1703425096ef2d2"
# "Inbox-Dev Candidates", "56b18f9457e1ce6491893b8e"
# "Inbox-QE Candidates", "56fe277f6ac80c11fa5b9cec"
# "Inbox-PDM/BA/SM Candidates", "56c1969319f0addf219a0170"
# "Coding Challenge Issued", "54d86885f56b47ee08048a85"
# "Completed Coding Challenge", "57874e92aaa63c769caa61ca"
# "Arranging Interview", "54d85234a56f6acac1559a37"
# "Interview Scheduled", "54dc1254030dead61cde7c3b"
# "Rejected and not yet informed", "57a8413822f6c5ac679e1262"
# "Rejected by GDS", "54d854731b54cd9079400d3b"
# "Interviewed and KIV", "54d8545ce898eca7c195c63c"
# "Pending Offer or Acceptance of Offer", "54f8f803acb1a56777766d43"
# "Offer Accepted", "54d85449dd8c06bb3b24d627"
# "MOM - Technical Interview", "54d8487805a10b13c1070a3f"
# "No action required (found other job, too long never contact etc.)", "57a84250c2bb6339e40b3c71"
# "Start date confirm!", "550fdd79c5491f754d74a7eb"

module Rtr # stands for Recrutiment Trello Ruby
  def initialize
    Trello.configure do |config|
      config.developer_public_key = ENV['BGP_REC_TRELLO_KEY']
      config.member_token = ENV['BGP_REC_TRELLO_TOKEN']
    end
  end

  def retrieve_idlers
    list = Trello::List.find("57874e92aaa63c769caa61ca")

    idling_more_than_a_week = []
    idling_more_than_a_day = []

    list.cards.each do |c|
      time_diff = Time.now - c.last_activity_date

      if (time_diff / 1.week).floor >= 1
        idling_more_than_a_week.push({ name: c.name })
      elsif (time_diff / 1.day).floor >= 1
        idling_more_than_a_day.push({ name: c.name })
      end
    end

    {
      idling_more_than_a_week: idling_more_than_a_week,
      idling_more_than_a_day: idling_more_than_a_day
    }
  end
end
