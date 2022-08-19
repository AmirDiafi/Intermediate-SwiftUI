//
//  MaginificationGestureBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/15/22.
//

import SwiftUI

struct MaginificationGestureBootcamp: View {
    
    var body: some View {
        VStack {
            PostHeader()
            PostContent()
            PostFoother()
            PostCaption()
        }
    }
}

struct MaginificationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaginificationGestureBootcamp()
    }
}
    

struct PostContent: View {
    @State private var currentZoom: CGFloat = 0
    private var width: CGFloat = UIScreen.main.bounds.width
    var body: some View {
        VStack{
            Image("prfl")
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: width, height: width)
                .scaleEffect(1 + currentZoom)
                .background(Color.black)
                .gesture(
                    MagnificationGesture()
                        .onChanged({ (value) in
                            withAnimation() {
                                currentZoom = value  - 0.5
                            }
                        })
                        .onEnded({ (value) in
                            withAnimation() {
                                currentZoom = 0
                            }
                        })
                )
        }
        
    }
}

struct PostHeader : View {
    var body: some View {
        HStack{
            Button(action:{}) {
                Image("prfl")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            Spacer()
            Button(action:{}) {
                Image(systemName: "ellipsis")
                    .foregroundColor(Color.primary)
            }
        }
        .padding(10)
    }
}

struct PostFoother : View {
    var body: some View {
        HStack{
            Button(action:{}) {
                Image(systemName: "heart")
                    .foregroundColor(Color.primary)
            }
        
            Button(action:{}) {
                Image(systemName: "message")
                    .foregroundColor(Color.primary)
            }
            Spacer()
        }
        .padding(10)
    }
}

struct PostCaption : View {
    var body: some View {
        VStack{
            Text("This is the caption of my photo")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
    }
}
