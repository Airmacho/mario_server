class Client < ApplicationRecord
  has_many :jobs
  has_many :plumbers, through: :jobs
  validates_presence_of :name, :address
end
