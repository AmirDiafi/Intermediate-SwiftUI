//
//  SwipedCart.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/16/22.
//

import SwiftUI

struct SwipedCart: View {
    @State private var translation: CGSize = .zero
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 300, height: 500)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .offset(translation)
                .rotationEffect(Angle(degrees: rotation))
                .scaleEffect(scale)
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            withAnimation(.spring()) {
                                self.translation = value.translation
                                self.scale = getScale()
                                self.rotation = getRotation()
                            }
                        })
                        .onEnded({ (value) in
                            withAnimation(.spring()) {
                                self.translation = .zero
                                self.scale = 1.0
                                self.rotation = 0
                            }
                        })
                )
                
        }
    }
    
    private func getScale() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentMovedValue = abs(translation.width)
        let percantageMovedValue = currentMovedValue / max
        return 1.0 - min(percantageMovedValue, 0.5) * 0.5
    }
    
    private func getRotation() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentMovedValue = translation.width
        let percantageMovedValue = currentMovedValue / max
        let maxValue: Double = 10
        let angleValue = maxValue * Double(percantageMovedValue)
        return angleValue
    }
    
}

struct SwipedCart_Previews: PreviewProvider {
    static var previews: some View {
        SwipedCart()
    }
}
