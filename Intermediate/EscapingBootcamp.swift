//
//  EscapingBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/8/22.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var data = "No Data to Show!"
    
    func getData(){
        downloadData { [weak self] (value) in
            self?.data = value.data
        }
    }
    
    func downloadData(completionHandler: @escaping downloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let result = DataTypes(data: "THIS IS THE RESULT 🙂")
            completionHandler(result)
        }
    }
}

struct DataTypes {
    let data: String
}

typealias downloadCompletion = (DataTypes) -> ()

struct EscapingBootcamp: View {
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        VStack{
            Text("GET DATA")
                .font(.title)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .padding()
                .background(Color.blue)
                .padding()
                .onTapGesture{
                    vm.getData()
                }
            Text(vm.data)
                .font(.headline)
                .foregroundColor(Color.gray)
        }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
