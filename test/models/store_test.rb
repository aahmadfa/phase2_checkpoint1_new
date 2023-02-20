require "test_helper"

class StoreTest < ActiveSupport::TestCase
  #Relationship
  should have_many(:assignments)
  should have_many(:employees).through(:assignments)

      # '''
    # #Store name
    # validates :name, presence:true, type: string, uniqueness: true
    
    # #Street
    # validates :street,  presence: true, type: string

    # #City
    # validates :city, presence: true, type: string

    # #State
    # validates :state, type: string, length: {is:2}, default: "PA", inclusion {in: %w[PA OH WV]}

    # #Zip
    # validates :zip, type: string, length: {is:5}, format: { with: /\A\d+\z/, message: "only allows numbers" }

    # #Phone
    # before_validation :normalize_phone_number
    # validates :phone, type: string, length: {is:10}, format: { with: /\A\d+\z/ }

    # #Active/Inactive
    # validates :active, type: boolean, inclusion: { in: [true, false] }
    # '''
  #Validations
  should validate_presence_of(:name)
  should validate_presence_of(:street)
  should validate_presence_of(:city)

  should_not allow_value("asdf").for(:phone)
  should_not allow_value("2362346").for(:zip)
  should_not allow_value("Michigan").for(:state)
  should_not allow_value("Yes").for(:active)
  should_not allow_value(1).for(:name)

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
