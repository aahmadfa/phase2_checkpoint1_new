require "test_helper"
  
class AssignmentTest < ActiveSupport::TestCase
  # Relationship macros
  should belong_to(:store)
  should belong_to(:employee)

  # Validation macros
  # should validate_presence_of(:store_id)
  # should validate_presence_of(:employee_id)
  # should validate_presence_of(:start_date)
  # should validate_presence_of(:end_date)
  # should_not allow_value(nil).for(:start_date)
  # should_not allow_value("bad").for(:due_on)
  # should_not allow_value(3.14159).for(:due_on)

  #contexts
  context "Creating assignments" do
    setup do
      create_employees
      create_stores
      create_assignments
    end

    teardown do
      destroy_assignments
      destroy_stores
      destroy_employees
    end

    should "have a scope to display current assignments" do
      assert_equal 3, Assignment.current.size
    end 

    should "return all past assignments" do
       assert_equal 0, Assignment.past.size
    end

    should "return all assignments ordered by store name" do
        assert_equal ["Coffee Bean", "Extra shot", "Starbucks"], Assignment.by_store.map{ |a| a.store.name }
    end

    should "return all assignments ordered by employee last name and first name" do
       assert_equal ["Heimann, Alex", "Heimann, Mark", "Heimann, Rachel"], Assignment.by_employee.map{|e| "#{e.employee.last_name}, #{e.employee.first_name}"}
    end

    should "return all assignments ordered chronologically with most recent assignments listed first" do
       assert_equal [@assignment1, @assignment2, @assignment3], Assignment.chronological.to_a
    end
    
    should "return all assignments associated with a given store" do
      assert_equal [@assignment1], Assignment.for_store(@store1)
      assert_equal 1, Assignment.for_store(@store1).size
    end

    should "return all assignments associated with a given employee" do
       assert_equal [@assignment1], Assignment.for_employee(@alex)
       assert_equal 1, Assignment.for_employee(@alex).size
    end

    should "return all assignments associated with employees of a given role" do
       assert_equal 3, Assignment.for_role("employee").size
    end

    should "return all assignments that were/are active on that particular date" do
       assert_equal [@assignment3], Assignment.for_date('2020-01-02')
    end
  end
end