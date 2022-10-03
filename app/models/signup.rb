class Signup < ApplicationRecord
    belongs_to :activity
    belongs_to :camper

    # Validations 
    validates :time, presence: true , numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 23} 
end
