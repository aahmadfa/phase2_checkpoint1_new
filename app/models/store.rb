class Store < ApplicationRecord
    has_many :assignments
    has_many :employees, through: :assignments

    
    #Store name
    validates :name, presence:true, uniqueness: {case_sensitive: false}
    
    #Street
    validates :street,  presence: true

    #City
    validates :city, presence: true
    
    #State
    validates :state, length: {is:2}, inclusion: {in: %w[PA OH WV]}

    #Zip
    validates :zip, length: {is:5}, format: { with: /\A\d+\z/, message: "only allows numbers" }

    #Phone
    
    validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
    after_validation :normalize_phone_number

    #Active/Inactive
    # validates :active, inclusion: { in: [true, false] }
    

    #Scopes
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order('name asc') }

    #Methods
    def make_active
        update(active: true)
    end
    
    def make_inactive
        update(active: false)
    end

    def normalize_phone_number
        phone = self.phone.to_s  # change to string in case input as all numbers 
        phone=phone.gsub(/[^0-9]/,"") # strip all non-digits: it substitutes all digits with empty character
        self.phone = phone       # reset self.phone to new string
    end

end