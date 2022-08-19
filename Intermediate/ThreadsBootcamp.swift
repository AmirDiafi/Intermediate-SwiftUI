//
//  ThreadsBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/7/22.
//

import SwiftUI

class ThreadVM: ObservableObject{
    @Published var data: [String] = []
    
    func fetchData(){
        DispatchQueue.global(qos: .background).async {
            print("global - thread, \(Thread.current)")
            print("global - is main thread: \(Thread.isMainThread)")
            DispatchQueue.main.async {
                print("main - thread, \(Thread.current)")
                print("main - is main thread: \(Thread.isMainThread)")
                self.data = self.downloadData()
            }
        }
    }
    
    func downloadData() -> [String] {
        var result: [String] = []
        
        for x in 0..<100 {
            result.append(x.description)
        }
        
        return result
    }
}

struct ThreadsBootcamp: View {
    @ObservedObject var vm = ThreadVM()
    var body: some View {
        ScrollView{
            VStack{
                Text("Load Data")
                    .font(.title)
                    .padding()
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.data, id: \.self) { (item) in
                    Text("Item No: \(item)")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
            }
        }
    }
}

struct ThreadsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ThreadsBootcamp()
    }
}
