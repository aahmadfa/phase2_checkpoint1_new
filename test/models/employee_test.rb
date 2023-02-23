require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  #Relationship
  should have_many(:assignments)
  should have_many(:stores).through(:assignments)

  #validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:ssn)
  should validate_presence_of(:date_of_birth)
  should validate_presence_of(:phone)
  should validate_presence_of(:role)

  should_not allow_value("asdf").for(:phone)
  should_not allow_value("1234567890721344153").for(:ssn)
  should allow_value("employee", "manager", "admin").for(:role)
  #should_not allow_value("ceo").for(:role)

  #contexts

  context "Creating a employee context" do
    # setting up the context
    setup do
      create_employees
    end
   
    # Tearing down the context
    teardown do
      destroy_employees
    end

    should "have a scope for active employees" do
      assert_equal 3, Employee.active.size
    end

    should "have a scope for inactive employees" do
      assert_equal 0, Employee.inactive.size
    end

    should "have a scope to order alphabetically by last name and first name" do
      assert_equal ["Alex", "Mark", "Rachel"], Employee.alphabetical.map{ |e| e.first_name }
    end

    should "have a scope for employees 18 or older" do
      assert_equal 3, Employee.is_18_or_older.size
    end

    should "have a scope for employees younger than 18" do
      assert_equal 0, Employee.younger_than_18.size
    end

    should "have a scope for regular employees" do
      assert_equal 3, Employee.employee.size
    end

    should "have a scope for manager employees" do
      assert_equal 0, Employee.manager.size
    end

    should "have a scope for admin employees" do
      assert_equal 0, Employee.admin.size
    end

    # methods
    should "return true if employee has a manager role" do
      refute @rachel.manager_role?
    end
      
    should "return true if employee has an admin role" do
      refute @alex.admin_role?
    end
      
    should "return true if employee has an employee role" do
      assert @mark.employee_role?, true
    end
      
    should "return last name, first name as a string" do
      assert_equal "Heimann, Alex", @alex.name
    end
      
    should "return proper name as a string" do
      assert_equal "Alex Heimann", @alex.proper_name
    end
      
    should "return current assignment or nil if no current assignment exists" do
      assert_equal @assignment1, @alex.current_assignment
    end
      
    should "return true if employee is over 18 years old" do
      assert @alex.over_18?
    end
      
    should "make employee active" do
      @alex.make_active
      assert @alex.active
    end
      
    should "make employee inactive" do
      @alex.make_inactive
      refute @alex.active
    end
      
    should "normalize SSN" do
      @alex.normalize_ssn
      assert_equal "123456789", @alex.ssn
    end
      
    should "normalize phone number" do
      @alex.normalize_phone_number
      assert_equal "4128978970", @alex.phone
    end
      
    should "validate date of birth is at least 14 years ago" do
      @alex.must_be_at_least_14_years_old
    end


 end #end of context
 
end