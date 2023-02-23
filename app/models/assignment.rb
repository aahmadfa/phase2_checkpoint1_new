class Assignment < ApplicationRecord
    belongs_to :store
    belongs_to :employee

    validates :store_id, presence: true, numericality: { only_integer: true }

    #employee id
    validates :employee_id, presence: true, numericality: { only_integer: true }

    #dates
    validates :start_date, presence: true
    validates_date :start_date, date: { on_or_before: Date.today }
    validates_date :end_date, date: { on_or_after: self.start_date }

    # Scopes
    scope :current, -> { where(end_date: nil)} #current assignments
    scope :past, -> { where.not(end_date: nil) } #past assignments
    scope :by_store, -> { joins(:store).order('stores.name') }
    scope :by_employee, -> { joins(:employee).order('employees.last_name, employees.first_name') }
    scope :chronological, -> { order('start_date DESC, end_date DESC') }
    scope :for_store, -> (store) {joins(:store).where('assignments.store_id = ?', store.id)}
    scope :for_employee, -> (employee) { joins(:employee).where('assignments.employee_id = ?', employee.id) }
    scope :for_role, -> (role) {joins(:employee).where('role = ?', Employee.roles[role])}
    scope :for_date, -> (date) {where('start_date <= ? AND (end_date > ? OR end_date IS NULL)', date, date)} #for date

    #Callback
    before_create :end_employee_assignment

    #Methods
    def end_employee_assignment
        employee = Employee.where(id: self.employee_id).first
        current_assignment = employee.current_assignment
        current_assignment.update_attribute(:end_date, self.start_date) unless current_assignment.nil?
    end