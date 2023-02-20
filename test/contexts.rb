module Contexts
    def create_assignments
        @assignment1 = FactoryBot.create(:assignment)
        @assignment2 = FactoryBot.create(:assignment, store_id:1, employee_id:1)
        @assignment3 = FactoryBot.create(:assignment, store_id:2, employee_id:2, start_date:"2020-01-01")
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
        @Store1 = FactoryBot.create(:store, name: 'Starbucks', phone: "4122683259")
        @Store2 = FactoryBot.create(:store)
        @Store3 = FactoryBot.create(:store, zip: "15213")
    end
      
    def destroy_stores
        @Store1.delete
        @Store2.delete
        @Store3.delete
    end
end

