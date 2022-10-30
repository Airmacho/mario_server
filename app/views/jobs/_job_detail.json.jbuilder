json.job_id job.id
json.client job.client, partial: "clients/client_except_private_note", as: :client
json.extract! job, :status, :started_at, :finished_at
