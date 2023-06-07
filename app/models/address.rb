class Address < ApplicationRecord
  belongs_to :user

  validates :parmanent_address, :residencial_address, :city, :state, :country, :pin, presence: true
  
end
