//
//  SwipeUpToSignup.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/16/22.
//

import SwiftUI

struct SwipeUpToSignup: View {
    private var height: CGFloat = UIScreen.main.bounds.height
    private var startYValue: CGFloat = UIScreen.main.bounds.height * 0.83
    @State private var currentDragedYValue: CGFloat = 0
    @State private var endingYVlaue: CGFloat = 0
    
    var body: some View {
        ZStack{
            Color.blue.ignoresSafeArea()
            Text("Hey there \(currentDragedYValue.description)")
                .zIndex(4)
            
            Signup()
                .offset(y: startYValue)
                .offset(y: currentDragedYValue)
                .offset(y: endingYVlaue)
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            let y = value.translation.height
                            withAnimation(.spring()) {
                                currentDragedYValue = y
                            }
                        })
                        .onEnded({ (value) in
                            let y = value.translation.height
                            withAnimation(.spring()) {
                                if y <= -height * 0.17 {
                                    endingYVlaue = -startYValue
                                } else if y > height * 0.17 {
                                    endingYVlaue = 0
                                }
                                
                                currentDragedYValue = 0
                            }
                        })
                )
            
        }
    }
}

struct Signup: View {
    var body: some View {
        VStack{
            Image(systemName: "chevron.up")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
            
            Text("Sign up")
                .font(.title3)
                .fontWeight(.bold)
                .padding()
            
            Image(systemName: "flame")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            
            Text("This is an account for the new social media platform, this platform is not like the others, is is the real platfrom for you and your real friends, there is no fake posts here!")
                .font(.headline)
                .padding(.vertical)
            
            Button(action:{}) {
                Text("Create an account".uppercased())
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.vertical)
                    .shadow(radius: 10)
            }
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct SwipeUpToSignup_Previews: PreviewProvider {
    static var previews: some View {
        SwipeUpToSignup()
    }
}
