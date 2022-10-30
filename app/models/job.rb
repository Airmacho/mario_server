class Job < ApplicationRecord
  # 0. when jobs are generated, the initial status should be allocated
  # 1. when plumbers manually close the event, set as complete
  # 2. canceled by admin
  enum status: { allocated: 0, completed: 1, canceled: 2 }, _prefix: :status

  validates_presence_of :plumber_id, :client_id, :started_at

  belongs_to :plumber
  belongs_to :client

  scope :starts_between, ->(time_range) { where(started_at: time_range) }
  scope :order_by_status_then_started_at, -> { order(status: :asc, started_at: :desc) }

  def self.filter_by_status_within_date_period(query_date, status)
    # assemble query clause by condition, due to AR is lazy loading, only one SQL is executed
    day_period_range = query_date.beginning_of_day..query_date.end_of_day
    jobs = Job.where(started_at: day_period_range)
    jobs = jobs.where(status: status) if status.present?
    # jobs = jobs.where(plumber_id: params[:plumber_ids]) if params[:plumber_ids].present?
    jobs
  end

  def mark_completed!
    unless status_allocated?
      self.errors.add(:base, 'status not applicable')
      return false
    end
    update!(status: :completed, finished_at: Time.now)
  end
end
