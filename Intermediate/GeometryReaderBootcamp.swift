//
//  GeometryReaderBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/20/22.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    
    private func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(0..<10, id: \.self) { index in
                    GeometryReader{ geometry in
                        RoundedRectangle(cornerRadius: 25.0)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 25),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 350, height: 200)
                    .padding()
                }
            }
        }
        
//        GeometryReader{ geometry in
//            HStack (spacing: 0){
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: geometry.size.width * 0.6666)
//                Rectangle().fill(Color.green)
//                Rectangle().fill(Color.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
