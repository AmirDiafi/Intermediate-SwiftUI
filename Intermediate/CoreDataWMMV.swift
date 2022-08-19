//
//  CoreDataWMMV.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/5/22.
//

import SwiftUI
import CoreData

class CoreDataModelView: ObservableObject{
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    static let shared = CoreDataModelView()
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { (description, error) in
            if (error != nil) {
                print("ERROR: \(error.debugDescription)")
                return
            }
        }
        fetchRequest()
    }
    
    func fetchRequest() {
        let req = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(req)
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteEntity(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateEntity(entity: FruitEntity) {
        entity.name = (entity.name ?? "") + " has been updated"
        saveData()
    }
    
    func saveData(){
        do {
            try container.viewContext.save()
            fetchRequest()
        } catch let error {
            print("ERROR saving: \(error)")
        }
    }
}

struct CoreDataWMMV: View {
    @ObservedObject var vm = CoreDataModelView.shared
    @State var fruit: String = ""
    
    var body: some View {
        NavigationView{
            VStack() {
                TextField("Add Fruit", text: $fruit)
                    .font(.headline)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                Button(action:{
                    guard !fruit.isEmpty else {return}
                    vm.addFruit(text: fruit)
                    fruit = ""
                }){
                    Text("ADD")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                List{
                    ForEach(vm.savedEntities) { (entity) in
                        Text(entity.name ?? "no name!")
                            .onTapGesture {
                                vm.updateEntity(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteEntity)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
            .navigationBarItems(leading: EditButton())
        }
    }
}

struct CoreDataWMMV_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataWMMV()
    }
}
