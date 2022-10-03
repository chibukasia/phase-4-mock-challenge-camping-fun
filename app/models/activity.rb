class Activity < ApplicationRecord
    has_many :signups, dependent: :destroy
    has_many :campers, through: :signups 

    # Validations 
    validates :name, presence: true
end
