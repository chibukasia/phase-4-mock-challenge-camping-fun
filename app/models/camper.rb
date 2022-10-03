class Camper < ApplicationRecord
    has_many :signups 
    has_many :activities, through: :signups

    # Validations 
    validates :name, presence: true 
    # validate :age_gap
    validates :age, numericality: {greater_than_or_equal_to: 8, less_than_or_equal_to: 18}

    # def age_gap 
    #     unless age && !age(8..18) 
    #         errors.add({message: "Age must be between 8 and 18"})
    #     end
    # end
end
