class Employee < ApplicationRecord
    has_many :assignments
    has_many :stores, through: :assignments

    
    # first name and last name
    validates :first_name, presence: true
    validates :last_name, presence: true
  
    # SSN
    before_validation :normalize_ssn #callback
    validates :ssn, presence: true, uniqueness: true, length: {is:9}, format: { with: /\A\d+\z/, message: "only allows numbers" }
  
    # Date of birth
    validates :date_of_birth, presence: true
    validate :must_be_at_least_14_years_old
    
    # Phone number
    before_validation :normalize_phone_number #callback
    validates :phone, presence: true, format: { with: /\A\d{10}\z/, message: "only allows numbers" }
  
    # Role
    enum role: {employee: 1,manager: 2, admin: 3 }
    validates :role, presence: true, inclusion: { in: roles.keys, message: "is not a valid role"}

    # active
    #validates :active, inclusion: { in: [true, false], message: "not a valid boolean"}
  
    # Scopes
    scope :active, -> {where(active: true)}
    scope :inactive, -> {where(active: false)}
    scope :alphabetical, -> {order(last_name: :asc, first_name: :asc)}
    scope :is_18_or_older, -> {where("date_of_birth <= ?", 18.years.ago.to_date)}
    scope :younger_than_18, -> {where("date_of_birth > ?", 18.years.ago.to_date)}
    scope :regulars, -> { where("role=?", roles["employee"]) }
    scope :managers, -> { where("role=?", roles["manager"]) }
    scope :admins, -> { where("role=?", roles["admin"]) }

  
    # Methods    

    def manager_role?
      self.role == 'manager'
    end

    def admin_role?
      self.role == 'admin'
    end

    def employee_role?
      self.role == 'employee'
    end

    def name
      "#{last_name}, #{first_name}"
    end
  
    def proper_name
      "#{first_name} #{last_name}"
    end
  
    def current_assignment
      current_assignment1 = self.assignments.current
      if current_assignment1.empty?
        return nil
      else 
        return current_assignment1.first
      end
    end
  
    def over_18?
      Date.today - date_of_birth >= 18
    end
  
    def make_active
      update(active: true)
    end
    
    def make_inactive
      update(active: false)
    end

    def normalize_ssn
      if self.ssn.present?
        self.ssn = ssn.gsub(/\D/, '')
      end
    end

    def normalize_phone_number
      if self.phone.present?
        self.phone = phone.gsub(/\D/, '')
      end
    end

    def must_be_at_least_14_years_old
      if date_of_birth.present? && date_of_birth > 14.years.ago.to_date
        errors.add(:date_of_birth, "must be at least 14 years old")
      end
    end
end