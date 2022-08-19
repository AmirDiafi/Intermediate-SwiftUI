//
//  CodableBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/8/22.
//

import SwiftUI

// Codebale =  Decodable + Encodable
struct CustomerModel: Identifiable, Codable {
    var id: String
    let name: String
    let points: Int
    let isPremium: Bool
}

class CodableViewModel: ObservableObject{
    @Published var data: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData(){
        guard let res = getJSONData() else {return}
        
        do {
            self.data = try JSONDecoder().decode(CustomerModel.self, from: res)
        } catch let error {
            print("ERROR: \(error.localizedDescription)")
        }
        
    }
    
    func getJSONData() -> Data? {
        let customer = CustomerModel(
            id: "123456",
            name: "Amir Diafi",
            points: 120,
            isPremium: true)
        
        let jsonData = try? JSONEncoder().encode(customer)
        return jsonData
    }
    
}

struct CodableBootcamp: View {
    @StateObject var vm = CodableViewModel()
    var body: some View {
        VStack{
            if let user = vm.data {
                Text("Name: \(user.name)")
                Text("Points: \(user.points.description)")
                Text("Premium: \(user.isPremium.description)")
            } else {
                Text("Oops! there is no user!")
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
