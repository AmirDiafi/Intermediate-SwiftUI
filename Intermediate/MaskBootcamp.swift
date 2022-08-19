//
//  MaskBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/23/22.
//

import SwiftUI

struct MaskBootcamp: View {
    @State var rateValue: Int = 0
    
    var body: some View {
        VStack{
            Text("Rate us!")
                .font(.title)
                .padding()
            starsView
                .overlay(overlayView.mask(starsView))
        }
    }
    
    private var overlayView: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .leading) {
                Rectangle()
//                    .fill(Color.yellow)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                    .frame(width: CGFloat(rateValue)/5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView : some View {
        HStack{
            ForEach(1..<6, id: \.self) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture(){
                        withAnimation(.easeInOut) {
                            rateValue = index
                        }
                    }
            }
        }
    }
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}
