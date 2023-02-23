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

 #scope
#  scope :active, -> {where(active: true)}
#  scope :inactive, -> {where(active: false)}
#  scope :alphabetical, -> {order(last_name: :asc, first_name: :asc)}
#  scope :is_18_or_older, -> {where("date_of_birth <= ?", 18.years.ago.to_date)}
#  scope :younger_than_18, -> {where("date_of_birth > ?", 18.years.ago.to_date)}
#  scope :regulars, -> { where("role=?", roles["employee"]) }
#  scope :managers, -> { where("role=?", roles["manager"]) }
#  scope :admins, -> { where("role=?", roles["admin"]) }
#  enum role: { employee: 1, manager: 2, admin: 3 }


 
 end #end of context
 
end