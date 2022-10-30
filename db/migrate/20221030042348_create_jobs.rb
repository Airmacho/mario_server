class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.references :plumber, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.integer :status, default: 0, comment: 'status of the job, allocated/completed/canceled'
      t.datetime :started_at, comment: 'the beginning time of the job starts(not created, for most senarioes, started_at comes later than created_at)'
      t.datetime :finished_at, comment: 'the time when job is completed by plumber'

      t.timestamps
    end
  end
end
