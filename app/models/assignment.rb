class Assignment < ApplicationRecord
    belongs_to :store
    belongs_to :employee

# 
#     #store id
#     validates :store_id, presence: true, type: integer

#     #employee id
#     validates :employee_id, presence: true, type: integer

#     #dates
#     validates :start_date, presence: true, type: date
#     validates :end_date, presence: true, type: date

#     validate :proper_dates
# 

    # Scopes
    scope :current, -> { where('end_date IS NULL')}
    scope :past, -> { where('end_date IS NOT NULL').where('end_date < ?', Date.today) }
    scope :by_store, -> { joins(:store).order('stores.name') }
    scope :by_employee, -> { joins(:employee).order('employees.last_name, employees.first_name') }
    scope :chronological, -> { order('end_date DESC, start_date DESC') }
    scope :for_store, -> (store) {joins(:store).where('assignments.store_id = ?', store.id)}
    scope :for_employee, -> (employee) { joins(:employee).where('assignments.employee_id = ?', employee.id) }
    scope :for_role, -> (role) {joins(:employee).where('role = ?', Employee.roles[role])}
    scope :for_date, -> (date) {where('start_date <= ? AND (end_date >= ? OR end_date IS NULL)', date, date)}


    #Callback
    #before_create :end_employee_assignment

    # #Methods
    # def end_employee_assignment
    #     current_assignment = employee.current_assignment
    #     current_assignment.update_attribute(:end_date, self.start_date) unless current_assignment.nil?
    # end

    # def proper_dates
    #     if start_date.nil?
    #         errors.add(:start_date, message: "why no start date?")
    #     elsif start_Date > Date.current
    #         errors.add(:start_date, message: "must be on or before present date")
    #     end
    
    #     if end_date.present? && end_date < start_date
    #         errors.add(:end_date, message: "must be after start date")
    #     end
    # end
end