//
//  CustomPublisherTimerBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/12/22.
//

import SwiftUI
import Combine

class CustomTimerViewModel: ObservableObject {
    @Published var count: Int = 0
    var cancelablles = Set<AnyCancellable>()
    
    init() {
        setCount()
    }
    
    func setCount() {
        Timer
            .publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {return}
                self.count += 1
                
                if self.count >= 10 {
                    for item in self.cancelablles {
                        item.cancel()
                    }
                }
            }
            .store(in: &cancelablles)
    }
}

struct CustomPublisherTimerBootcamp: View {
    @StateObject var vm = CustomTimerViewModel()
    var body: some View {
        VStack {
            Text("Count: \(vm.count)")
                .font(.title)
                .foregroundColor(Color.blue)
        }
    }
}

struct CustomPublisherTimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomPublisherTimerBootcamp()
    }
}
