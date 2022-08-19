//
//  ScrollViewReaderBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/16/22.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    @State var scrollToIndex: Int = 0
    @State var textField: String = ""
    var body: some View {
        VStack {
            
            VStack{
                TextField("Index number to scroll here" , text: $textField)
                    .frame(height: 50)
                    .padding(.leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.bottom, 10)
                
                Button(action:{
                    withAnimation(.spring()) {
                        if let index = Int(textField) {
                            scrollToIndex = index
                        }
                    }
                }) {
                    Text("Scroll To")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
            .padding()
            
            ScrollView{
                ScrollViewReader{ proxy in
                    ForEach(0..<50, id: \.self) { index in
                        Text("Item No. \(index)")
                            .font(.title)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(scrollToIndex==index ? Color.blue:Color.green)
                            .cornerRadius(15)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .padding()
                            .id(index)
                            .onTapGesture {
                                textField = index.description
                                scrollToIndex = index
                            }
                    }
                    .onChange(of: scrollToIndex, perform: { value in
                        withAnimation(.spring()) {
                            proxy.scrollTo(value, anchor: .center)
                        }
                    })
                }
            }
        }
    }
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
