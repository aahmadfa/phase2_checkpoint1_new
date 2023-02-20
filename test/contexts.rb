module Contexts
    def create_assignments
        @assignment1 = FactoryBot.create(:assignment)
        @assignment2 = FactoryBot.create(:assignment, store_id:2, employee_id:2, start_date:"2020-02-01")
        @assignment3 = FactoryBot.create(:assignment, store_id:3, employee_id:3, start_date:"2020-01-01")
    end

    def destroy_assignments
        @assignment1.delete
        @assignment2.delete
        @assignment3.delete
    end

    def create_employees
        @alex = FactoryBot.create(:employee)
        @rachel = FactoryBot.create(:employee, first_name: "Rachel", active: false)
        @mark = FactoryBot.create(:employee, first_name: "Mark", phone: "412-268-8211")
      end
      
    def destroy_employees
        @alex.delete
        @rachel.delete
        @mark.delete
    end

    def create_stores
        @store1 = FactoryBot.create(:store, name: 'Starbucks', phone: "4122683259")
        @store2 = FactoryBot.create(:store, name: 'Extra shot', store_id: 2)
        @store3 = FactoryBot.create(:store, store_id: 3, zip: "15213")
    end
      
    def destroy_stores
        @Store1.delete
        @Store2.delete
        @Store3.delete
    end
end

