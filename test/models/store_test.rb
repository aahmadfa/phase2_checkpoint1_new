require "test_helper"

class StoreTest < ActiveSupport::TestCase
  #Relationship
  should have_many(:assignments)
  should have_many(:employees).through(:assignments)

  #Validations
  should validate_presence_of(:name)
  should validate_presence_of(:street)
  should validate_presence_of(:city)

  should_not allow_value("asdf").for(:phone)
  should_not allow_value("111/111/1111").for(:phone)
  should_not allow_value("2362346").for(:zip)
  should_not allow_value("Michigan").for(:state)
  # should_not allow_value("Yes").for(:active)

  context "Creating a store context" do
    # setting up the context
    setup do
      create_stores
    end
   
    # Tearing down the context
    teardown do
      destroy_stores
    end

  #scopes
  should "return only active stores" do
    assert_equal [@store1, @store2, @store3], Store.active
  end

  should "return all inactive stores" do
    assert_equal [], Store.inactive
  end

  should "return stores ordered alphabetically" do
    assert_equal [@store3, @store2, @store1], Store.alphabetical
  end
end
end