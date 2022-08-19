//
//  DragGestureBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/15/22.
//

import SwiftUI

struct DragGestureBootcamp: View {
    @State private var draged: Bool = false
    @State private var x: CGFloat = 0
    @State private var y: CGFloat = 0
    private let boxSize: CGFloat = 100
    
    var body: some View {
        RoundedRectangle(cornerRadius: boxSize)
            .fill(draged ? Color.blue : Color.red)
            .frame(width: boxSize, height: boxSize)
            .foregroundColor(Color.white)
            .shadow(
                color: draged ?
                    Color.blue.opacity(0.5) :
                    Color.red.opacity(0.5),
                radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0.0, y: 20
            )
            .offset(x: x, y: y)
            .gesture(
                DragGesture()
                    .onChanged({ (value) in
                        withAnimation(.spring()) {
                            draged = true
                            x = value.location.animatableData.first - (boxSize/2)
                            y = value.location.animatableData.second - (boxSize/2)
                        }
                    })
                    .onEnded({ (value) in
                        withAnimation(.spring()) {
                            draged = false
                            x = 0
                            y = 0
                        }
                    })
            )
            
    }
}

struct DragGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp()
    }
}
