FactoryBot.define do
  factory :job do
    plumber { nil }
    client { nil }
    status { 0 }
    started_at { "2022-10-30 12:23:49" }
    finished_at { "2022-10-30 12:23:49" }
  end

  factory :job_allocated, class: 'Job' do
    plumber { nil }
    client { nil }
    status { 0 }
    started_at { "2022-10-30 12:23:49" }
  end

  factory :job_completed, class: 'Job' do
    plumber { nil }
    client { nil }
    status { Job.statuses['completed'] }
    started_at { Time.now }
    finished_at { Time.now }
  end
end
