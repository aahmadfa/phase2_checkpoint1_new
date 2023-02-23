module Contexts
    def create_assignments
        @assignment1 = FactoryBot.create(:assignment, store_id:1, employee_id:1)
        @assignment2 = FactoryBot.create(:assignment, store_id:2, employee_id:2, start_date:"2020-02-01")
        @assignment3 = FactoryBot.create(:assignment, store_id:3, employee_id:3, start_date:"2020-01-01")
    end

    def destroy_assignments
        @assignment1.delete if @assignment1
        @assignment2.delete if @assignment2
        @assignment3.delete if @assignment3
    end

    def create_employees
        @alex = FactoryBot.create(:employee, role: 1)
        @rachel = FactoryBot.create(:employee, first_name: "Rachel", ssn: "987654321", role:1)
        @mark = FactoryBot.create(:employee, first_name: "Mark", ssn: "654321761", phone: "412-268-8211", role: 1)
      end
      
    def destroy_employees
        @alex.delete if @alex
        @rachel.delete if @rachel
        @mark.delete if @mark
    end

    def create_stores
        @store1 = FactoryBot.create(:store, name: 'Starbucks', phone: "4122683259")
        @store2 = FactoryBot.create(:store, name: 'Extra shot')
        @store3 = FactoryBot.create(:store, zip: "15213")
    end
      
    def destroy_stores
        @store1.delete if @store1
        @store2.delete if @store2
        @store3.delete if @store3
    end
end

