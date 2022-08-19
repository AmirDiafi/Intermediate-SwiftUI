//
//  SwipeToDelete.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/15/22.
//

import SwiftUI

struct SwipeToDelete: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let buttonWidth: CGFloat = 80
    let buttonPadding: CGFloat = 20
    let buttonAcutalWidth: CGFloat = 80 + (20 * 2)
    
    @State private var xValue: CGFloat = 0
    
    
    var body: some View {
        VStack {
            Text("\((xValue).description) > \(buttonAcutalWidth.description)")
                .font(.title3)
            
            ZStack{
                //MARK: Actions
                HStack(spacing: 0){
                    Button(action:{
                        withAnimation(.spring()) {
                            xValue = 0
                        }
                    }) {
                        Text("Edit")
                            .frame(maxHeight: 60)
                            .frame(width: buttonWidth)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.2))
                    }
                    Button(action:{
                        withAnimation(.spring()) {
                            xValue = 0
                        }
                    }) {
                        Text("Delete")
                            .frame(maxHeight: 60)
                            .frame(width: buttonWidth)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(Color.red)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .frame(height: 60)
                .background(Color.gray)
                
                //MARK: User item
                HStack {
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Amir Diafi")
                            .font(.title3)
                        Text("@amirdiafi")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .padding(.horizontal, 10)
                .background(Color.white)
                .offset(x: xValue)
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            let x = value.translation.animatableData.first
                            // dragable on the right only
                            if x <= 0 {
                                withAnimation(){
                                    xValue = x
                                }
                            }
                        })
                        .onEnded({ (value) in
                            let x = abs(value.translation.animatableData.first)

                            if x >= buttonAcutalWidth && x < buttonAcutalWidth * 2 {
                                withAnimation(.spring()) {
                                    xValue = -buttonAcutalWidth
                                }
                            } else if x >= buttonAcutalWidth * 2 {
                                withAnimation(.spring()) {
                                    xValue = -buttonAcutalWidth * 2
                                }
                            } else {
                                withAnimation(.spring()) {
                                    xValue = 0
                                }
                            }
                        })
                )
            }
        }
    }
}

struct SwipeToDelete_Previews: PreviewProvider {
    static var previews: some View {
        SwipeToDelete()
    }
}
