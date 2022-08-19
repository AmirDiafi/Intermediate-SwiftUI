//
//  CoreDataRelationship.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/5/22.
//

import SwiftUI
import CoreData

// Constants
let buttonSpacer: CGFloat = 5

class CoreDataManager{
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "EmployeeCoreData")
        container.loadPersistentStores { (desc, error) in
            if error != nil {
                print("ERROR Fetching: \(error.debugDescription)")
                return
            }
        }
        context = container.viewContext
    }

    
    func saveData(){
        do {
            try context.save()
        } catch let error {
            print("ERROR \(error)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject{
    let manager = CoreDataManager.instance
    static let shared = CoreDataRelationshipViewModel()
    @Published var data: [BusinessEntity] = []
    @Published var departs: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        fetchBusinessData()
        fetchDepartmentsData()
        fetchEmployeessData()
    }
    
    func fetchBusinessData() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do {
            try data = manager.context.fetch(request)
        } catch let error {
            print("ERROR \(error)")
        }
    }
    
    func fetchDepartmentsData() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            try departs = manager.context.fetch(request)
        } catch let error {
            print("ERROR \(error)")
        }
    }
    
    func fetchEmployeessData() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            try employees = manager.context.fetch(request)
        } catch let error {
            print("ERROR \(error)")
        }
    }
    
    func addBusiness(){
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        let filteredDepartments = departs.filter({ (department) -> Bool in
            (department.businesses?.contains(newBusiness) ?? false)
        })
        newBusiness.departments = NSSet(array: filteredDepartments)
        
        let filteredEmployees = employees.filter({ (employee) -> Bool in
            employee.business?.name == "Apple"
        })
        newBusiness.employees = NSSet(array: filteredEmployees)
        
        saveAndRefresh()
    }
    
    func addDepartment(){
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Marketing"
        let filteredBusiness = data.filter({ (business) -> Bool in
            business.name == "Apple"
        })
        newDepartment.businesses = NSSet(array: filteredBusiness)
        
        let filteredEmployees = employees.filter({ (employee) -> Bool in
            employee.department?.name == "Apple"
        })
        print(filteredEmployees)
        newDepartment.employees = NSSet(array: filteredEmployees)
        
        saveAndRefresh()
    }

    func addEmployee(){
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Amir"
        newEmployee.age = 26
        newEmployee.dateJoined = Date()
        
        if let department = departs.filter({ (department) -> Bool in
            department.name == "Marketing"
        }).first {
            newEmployee.department = department
        }
        
        if let business = data.filter({ (business) -> Bool in
            business.name == "Apple"
        }).first {
            newEmployee.business = business
        }
        
        saveAndRefresh()
    }

    func deleteBusiness() {
        // TODO:
    }

    func saveAndRefresh(){
        data.removeAll()
        departs.removeAll()
        employees.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.saveData()
            self.fetchBusinessData()
            self.fetchDepartmentsData()
            self.fetchEmployeessData()
        }
    }
}

struct CoreDataRelationship: View {
    let vm = CoreDataRelationshipViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                HStack(spacing: buttonSpacer){
                    AddButton(action: vm.addBusiness, title: "Add Business \(vm.data.count)")
                    AddButton(action: vm.addDepartment, title: "Add Department")
                    AddButton(action: vm.addEmployee, title: "Add Employee")
                }
                .padding(.vertical)
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(vm.data, content: {entity in
                            BusinessView(entity: entity)
                        })
                        .onDelete(perform: { indexSet in
                            print("Bye")
                        })
                    }
                    .padding(.horizontal)
                }
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(vm.departs, content: {entity in
                            DepartmentView(entity: entity)
                        })
                        .onDelete(perform: { indexSet in
                            print("Bye")
                        })
                    }
                    .padding(.horizontal)
                }
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(vm.employees, content: {entity in
                            EmployeeView(entity: entity)
                        })
                        .onDelete(perform: { indexSet in
                            print("Bye")
                        })
                    }
                    .padding(.horizontal)
                }
                
            }
            .navigationTitle("CoreData Relationship")
            .navigationBarItems(leading: EditButton())
        }
    }
}

struct CoreDataRelationship_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationship()
    }
}

struct BusinessView: View {
    let entity: BusinessEntity
    var body: some View {
        VStack(alignment: .leading){
            Text("Business: ")
                .font(.title3)
            Text(entity.name ?? "no business name")
                .font(.title2)
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments: ")
                    .font(.title3)
                ForEach(departments) { (dep) in
                    Text(dep.name ?? "")
                }
            }
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .font(.title3)
                ForEach(employees) { (employee) in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

struct DepartmentView: View {
    let entity: DepartmentEntity
    var body: some View {
        VStack(alignment: .leading){
            Text("Department: ")
                .font(.title3)
            Text(entity.name ?? "no department name")
                .font(.title2)
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .font(.title3)
                ForEach(employees) { (employee) in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .background(Color(.systemGreen))
        .cornerRadius(10)
    }
}

struct EmployeeView: View {
    let entity: EmployeeEntity
    var body: some View {
        VStack(alignment: .leading){
            Text("Name: \(entity.name ?? "")")
                .font(.title3)
            
            Text("age: \(entity.age.description)")
                .font(.title3)
        
            Text("Joined Date: \(entity.dateJoined?.description ?? "")")
                .font(.title3)
            
            Text("Dep: \(entity.department?.name ?? " no dep")")
        }
        .padding()
        .background(Color(.systemBlue))
        .cornerRadius(10)
    }
}

struct AddButton: View {
    let width = UIScreen.main.bounds.width
    let action : () -> Void
    let title: String
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: (width-buttonSpacer*6)/3, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}

//private func dateFormatter(date: Date) {
//    let formatter = DateFormatter()
//    formatter
//}
