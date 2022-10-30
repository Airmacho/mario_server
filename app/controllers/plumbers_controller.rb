class PlumbersController < ApplicationController
  before_action :set_plumber, only: [:jobs]

  def create
    @plumber = Plumber.new(plumber_params)

    if @plumber.save
      render :show, status: :created, location: @plumber
    else
      render json: @plumber.errors, status: :unprocessable_entity
    end
  end

  # return jobs assigned to a plumber between a certain time period. 
  # This should include client details except private note
  def jobs
    @jobs = @plumber.get_jobs_between(params[:starts_at], params[:ends_at])
    render :job_details, status: :ok
  end

  private

    def set_plumber
      @plumber = Plumber.find(params[:plumber_id])
    end

    def plumber_params
      params.require(:plumber).permit(:name, :address, :vehicles)
    end
end
