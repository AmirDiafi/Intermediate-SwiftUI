//
//  RotationGestureBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/15/22.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    @State private var angle: Angle = Angle(degrees: 0)
    var body: some View {
        Text(String(describing: angle.degrees))
            .frame(width: 300, height: 150)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .rotationEffect(angle)
            .font(.title)
            .shadow(radius: 10)
            .gesture(
                RotationGesture()
                    .onChanged({ (value) in
                        angle = value
                    })
                    .onEnded({ (value) in
                        withAnimation(.spring()){
                            angle = Angle(degrees: 0)
                        }
                    })
                    
            )
    }
}

struct RotationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureBootcamp()
    }
}
