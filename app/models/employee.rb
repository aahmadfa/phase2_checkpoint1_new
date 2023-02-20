class Employee < ApplicationRecord
    has_many :assignments
    has_many :stores, through: :assignments
  
    # '''
    # # first name and last name
    # validates :first_name, presence: true
    # validates :last_name, presence: true
  
    # # SSN
    # before_validation :normalize_ssn #callback
    # validates :SSN, presence: true, uniqueness: true, length: {is:9}, format: { with: /\A\d+\z/, message: "only allows numbers" }
  
    # # Date of birth
    # validates :date_of_birth, presence: true, inclusion: {
    #   in: proc {14.years.ago.to_date},
    #   message: "must be 14 years or older"
    # }
  
    # # Phone number
    # before_validation :normalize_ssn #callback
    # validates :phone, presence: true, length: {is:10}, format: { with: /\A\d+\z/, message: "only allows numbers" }
  
    # # Role
    # validates :role, presence: true, inclusion: {in: 1..3, message: "is not a valid role"}

    # # active
    # validates :active, default: true, inclusion: { in: [true, false], message: "not a valid boolean"}
    # '''
  
    # Scopes
    scope :active, -> {where(active: true)}
    scope :inactive, -> {where(active: false)}
    scope :alphabetical, -> {order(last_name: :asc, first_name: :asc)}
    scope :is_18_or_older, -> {where("date_of_birth <= ?", 18.years.ago.to_date)}
    scope :younger_than_18, -> {where("date_of_birth > ?", 18.years.ago.to_date)}
    scope :regulars, -> { where("role=?", roles["employee"]) }
    scope :managers, -> { where("role=?", roles["manager"]) }
    scope :admins, -> { where("role=?", roles["admin"]) }
    enum role: { employee: 1, manager: 2, admin: 3 }
  
    # # Methods    
    # def name
    #   "#{last_name}, #{first_name}"
    # end
  
    # def proper_name
    #   "#{first_name} #{last_name}"
    # end
  
    # def current_assignment
    #   assignments.where("start_date <= ? AND (end_date >= ? OR end_date IS NULL", Date.today, Date.today).first
    # end
  
    # def over_18?
    #   date.today - date_of_birth > 18
    # end
  
    # def make_active
    #   update(active: true)
    # end
    
    # def make_inactive
    #   update(active: false)
    # end

    # def normalize_ssn
    #     self.SSN = SSN.gsub(/\D/, '')
    # end

    # def normalize_phone_number
    #     self.phone = phone.gsub(/\D/, '')
    # end
end