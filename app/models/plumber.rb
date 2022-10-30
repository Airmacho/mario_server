class Plumber < ApplicationRecord
  has_many :jobs
  has_many :clients, through: :jobs

  def get_jobs_between(starts_at, ends_at)
    time_range = Time.parse(starts_at)..Time.parse(ends_at)
    # use includes to eager load, avoid n+1 problem
    jobs.includes(:client).starts_between(time_range).order_by_status_then_started_at
  rescue ArgumentError
    []
  end
end
