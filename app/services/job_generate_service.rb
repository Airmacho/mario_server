class JobGenerateService < BaseService
    attr_reader :job_params
    attr_accessor :errors
    attr_accessor :data

    def initialize(job_params)
        @job_params = job_params
        @errors = []
        @data = []
    end

    def call
        plumbers = Plumber.where(id: @job_params[:plumber_ids])
        if plumbers.blank? && plumbers.size != @job_params[:plumber_ids].size
            diff = @job_params[:plumber_ids].to_set - plumbers.pluck(:id).to_set
            @errors.append("plumbers with id #{diff.to_a} not found")
            return false
        end

        client = Client.find_by(id: @job_params[:client_id])
        if !client.present?
            @errors.append("client not found")
            return false
        end

        started_at = @job_params[:started_at]
        batch_insert_params = @job_params[:plumber_ids].map do |plumber_id|
            { plumber_id:  plumber_id, client_id: client.id, started_at: started_at}
        end
        

        Job.transaction do
            jobs = Job.create(batch_insert_params)
            self.data = jobs
        end
        true
    end

    def error_messages
        @errors.join(';')
    end
end