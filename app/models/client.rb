class Client < ApplicationRecord
  has_many :jobs
  has_many :plumbers, through: :jobs
end
