require 'rufus-scheduler'
require_relative 'job'

scheduler = Rufus::Scheduler.new
job = Job.new

# Every weekday, 9:20am before standup
scheduler.cron '20 9 * * 1-5', first: :now do
  message = job.retrieve_idlers.to_message
  job.recipients.each do |r|
    job.send(message, r)
  end
end

scheduler.join
