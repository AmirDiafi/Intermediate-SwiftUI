//
//  LongPressGestureBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/15/22.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    @State private var isInProgress: Bool = false
    @State private var isCompleted: Bool = false
    var timeToCoplete: Double = 1.0
    
    var body: some View {
        VStack{
            
            Rectangle()
                .fill(isCompleted ? Color.green : Color.blue)
                .frame(maxWidth: isInProgress ? .infinity : 0)
                .frame(height: 70)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
                .overlay(
                    Text(isCompleted ? "Completed".uppercased() : isInProgress ? "In progress".uppercased() : "empty".uppercased())
                        .font(.title)
                        .foregroundColor(Color.white)
                )
            
            HStack{
                Text(isInProgress ? "COMPLETE" : "COMPLETED")
                    .padding()
                    .background(isCompleted ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    .onLongPressGesture(minimumDuration: timeToCoplete, maximumDistance: 50) { (isPressing) in
                        // start of press -> min duration
                        if isPressing {
                            withAnimation(Animation.easeIn(duration: timeToCoplete)) {
                                isInProgress = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                if !isCompleted {
                                    withAnimation(
                                        Animation.easeIn(duration: timeToCoplete)) {
                                        isInProgress = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // at min duration
                        if !isCompleted {
                            withAnimation(Animation.easeIn(duration: timeToCoplete)) {
                                isCompleted = true
                            }
                        }
                    }

                
                Text("RESET")
                    .padding()
                    .background(isInProgress || isCompleted ? Color.blue : Color.gray)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    .onTapGesture(count: 1, perform: {
                        if isInProgress || isCompleted {
                            withAnimation(Animation.easeIn(duration: timeToCoplete)) {
                                isInProgress = false
                                isCompleted = false
                            }
                        }
                    })
            }
            .padding()
            
        }
        
        
        
        
        
//        Text(isPressed ? "COMPLETED" : "NOT COMPLETED")
//            .font(.headline)
//            .frame(width: 200, height: 50)
//            .background(isPressed ? Color.green : Color.blue)
//            .foregroundColor(Color.white)
//            .cornerRadius(10)
//            .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 30.0) {
//                withAnimation() {
//                    isPressed.toggle()
//                }
//            }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
