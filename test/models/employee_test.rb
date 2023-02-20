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
  should_not allow_value(5).for(:role)


  #contexts
  should "return only active employees" do
    assert_equal [@alex, @mark], Employee.active
  end

  should "return all inactive employees" do
    assert_equal [@rachel], Employee.inactive
  end

  should "return all active employees in alphabetical order by last name, first name" do
    assert_equal ["Heimann, Alex", "Heimann, Mark", "Heimann, Rachel"], Employee.alphabetical.map{|e| "#{e.first_name}, #{e.last_name}"}
  end

  should "return all employees 18 years old or older" do
    assert_equal [@alex, @mark], Employee.is_18_or_older
  end

  should "return all employees under 18 years old" do
    assert_equal [], Employee.younger_than_18
  end

  should "return all employees who have the role 'employee'" do
    assert_equal [@alex, @mark, @rachel], Employee.regulars
  end

  should "return all employees who have the role 'manager'" do
    assert_equal [], Employee.managers
  end

  should "return all employees who have the role 'admin'" do
    assert_equal [], Employee.admins
  end
end
