require_relative 'rtr'

class Job
  attr_reader :week_idlers, :day_idlers
  include Rtr

  def update
    idlers = retrieve_idlers
    @week_idlers = idlers[:idling_more_than_a_week]
    @day_idlers = idlers[:idling_more_than_a_day]
  end
end

job = Job.new
job.update

p job.week_idlers
p job.day_idlers
