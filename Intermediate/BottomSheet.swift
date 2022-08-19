//
//  BottomSheet.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/15/22.
//

import SwiftUI

struct BottomSheet: View {
    private let width: CGFloat = UIScreen.main.bounds.width
    private let height: CGFloat = UIScreen.main.bounds.height
    
    @State var isDisplayed: Bool = false
    @State var bottomSheetPositionY: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView{
                Text("Home \(isDisplayed.description) + \(bottomSheetPositionY.description)")
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation() {
                            if !isDisplayed {
                                isDisplayed = true
                                bottomSheetPositionY = 0
                            } else {
                                isDisplayed = false
                                bottomSheetPositionY = width
                            }
                        }
                    }
                    .tabItem {
                        Label(
                            title: { Text("Home") },
                            icon: { Image(systemName: "house") }
                        )
                    }
                    .onTapGesture {
                        withAnimation() {
                           isDisplayed = false
                            bottomSheetPositionY = 0
                        }
                    }
                
                Text("Hots")
                    .tabItem {
                        Label(
                            title: { Text("Hots") },
                            icon: { Image(systemName: "flame") }
                        )
                    }
            
                Text("Profile")
                    .tabItem {
                        Label(
                            title: { Text("Profile") },
                            icon: { Image(systemName: "person") }
                        )
                    }
            }
            DynamicBottomSheet(
                isDisplayed: $isDisplayed,
                bottomSheetPositionY: $bottomSheetPositionY
            )
        }
        .ignoresSafeArea()

    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
            .previewDevice("iPhone 11")
    }
}

struct DynamicBottomSheet: View {
    private let width: CGFloat = UIScreen.main.bounds.width
    private let height: CGFloat = UIScreen.main.bounds.height
    @Binding var isDisplayed: Bool
    @Binding var bottomSheetPositionY: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.blue)
            .frame(width: width, height: width)
            .zIndex(10)
            .offset(y: bottomSheetPositionY)
            .gesture(
                DragGesture()
                    .onChanged({ (value) in
                        let y: CGFloat = value.translation.animatableData.second
                        if y > 0 {
                            bottomSheetPositionY = y
                        }
                    })
                    .onEnded({ (value) in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            let y: CGFloat = value.translation.animatableData.second
                            withAnimation(.spring()) {
                                if y > (width/2) {
                                    bottomSheetPositionY = width
                                    isDisplayed = false
                                } else {
                                    bottomSheetPositionY = 0
                                    isDisplayed = true
                                }
                            }
                        }
                    })
            )
    }
}
