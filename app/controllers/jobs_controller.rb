class JobsController < ApplicationController
  before_action :set_job, only: :destroy

  # filter by status in a date period(which covers the scope of currently allocated jobs in a date period)
  def index
    render_bad_request and return if params[:query_date].blank?  
        
    query_date = parse_date(params[:query_date])
    render_bad_request and return if query_date.blank?

    @jobs = Job.filter_by_status_within_date_period(query_date, params[:status])
  end

  def create
    if (params[:plumber_ids].blank? || params[:client_id].blank?)
      render status: :unprocessable_entity, json: 'required parameters missing' and return
    end
    # use service object to wrap job generating logic
    # https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
    job_service = JobGenerateService.new(params)
    if job_service.call
      @jobs = job_service.data
      render status: :created, json: @jobs
    else
      render json: job_service.error_messages, status: :unprocessable_entity
    end
  end

  def complete
    # to avoid horizontal access controls breach, should query with plumber
    @job = Job.find_by(plumber_id: params[:plumber_id], id: params[:id])
    raise ActiveRecord::RecordNotFound unless @job
    if @job.mark_completed!
      render :show, status: :ok
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    def parse_date(date)
      Time.parse(date)
    rescue ArgumentError
      nil
    end

    def render_bad_request
      render json: [], status: :bad_request
    end
end
