require "test_helper"
  
class AssignmentTest < ActiveSupport::TestCase
  # Relationship macros
  should belong_to(:store)
  should belong_to(:employee)

  # Validation macros
  should validate_presence_of(:store_id)
  should validate_presence_of(:employee_id)
  should validate_presence_of(:start_date)
  should validate_presence_of(:end_date)
  should_not allow_value(nil).for(:start_date)
  should_not allow_value("bad").for(:due_on)
  should_not allow_value(3.14159).for(:due_on)

  #contexts
  context "Creating assignments" do
    setup do
      create_assignments
      create_employees
      create_stores
    end

    teardown do
      destroy_assignments
      destroy_employees
      destroy_stores
    end

# # Scopes
# scope :current, -> { where(end_date:nil)} #current assignments
# scope :past, -> { where.not(end_date:nil) } #past assignments
# scope :by_store, -> { joins(:store).order('stores.name') }
# scope :by_employee, -> { joins(:employee).order('employees.last_name, employees.first_name') }
# scope :chronological, -> { order('start_date DESC, end_date DESC') }
# scope :for_store, -> (store) {joins(:store).where('assignments.store_id = ?', store.id)}
# scope :for_employee, -> (employee) { joins(:employee).where('assignments.employee_id = ?', employee.id) }
# scope :for_role, -> (role) {joins(:employee).where('role = ?', Employee.roles[role])}
# scope :for_date, -> (date) {where('start_date <= ? AND (end_date > ? OR end_date IS NULL)', date, date)} #for date


    should "have a scope to display current assignments" do
      assert_equal nil, Assignment.end_date
    end 

    should_not "return all past assignments" do
      assert_equal nil, Assignment.end_date
    end

    should "return all assignments ordered by store name" do
        assert_equal ["CoffeeBean", "Starbucks"], Assignment.by_store.map{ |a| a.store.name }
    end

    should "return all assignments ordered by employee last name and first name" do
      assert_equal ["Heimann, Alex", "Heimann, Mark", "Heimann, Rachel"], Assignment.by_employee.map{|e| "#{e.employee.last_name}, #{e.employee.first_name}"}
    end

    should "return all assignments ordered chronologically with most recent assignments listed first" do
      assert_equal [@assignment1, @assignment2, @assignment3], Assignment.chronological
    end
    
    should "return all assignments associated with a given store" do
      assert_equal [@assignment1, @assignment2, @assignment3], Assignment.for_store(@store1)
    end

    should "return all assignments associated with a given employee" do
      assert_equal [@assignment1], Assignment.for_employee(@employee1)
    end

    should "return all assignments associated with employees of a given role" do
      assert_equal [@assignment1, @assignment2, @assignment3], Assignment.for_role(1)
    end

    should "return all assignments that were/are active on that particular date" do
      assert_equal [@assignment3], Assignment.for_date('2020-01-02')
    end
  end
end