//
//  Timers&OnReceiveBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/11/22.
//

import SwiftUI

struct Timers_OnReceiveBootcamp: View {
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    //TIMER
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    */

    //COUNTDOWN
    /*
    @State var counter: Int = 10
    @State var finishedText: String? = nil
    */
    
    //DATE COUNTDOWN
    /*
     @State var timeRemaining: String = ""
     let futureDate: Date = Calendar.current.date(byAdding: .minute, value: 2, to: Date()) ?? Date()
     
     func updateDate() {
         let remaining = Calendar
             .current.dateComponents(
                 [.hour, .minute, .second],
                 from: Date(),
                 to: futureDate)
         let hours = remaining.hour ?? 0
         let minutes = remaining.minute ?? 0
         let seconds = remaining.second ?? 0
         
         if minutes <= 0 && seconds <= 0 {
             timeRemaining = "FINISHED"
         } else {
             timeRemaining = "\(hours):\(minutes):\(seconds)"
         }
         
     }
     */
    
    //ANIMATION
    @State var selectedCircle: Int = 0
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))]),
                center: .center,
                startRadius: 500,
                endRadius: 5)
                .ignoresSafeArea()
            
            VStack{
                Text("")
                    .font(.system(size: 100, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
            }
            .padding()
            
//            HStack(spacing: 25) {
//                Circle()
//                    .fill(Color.white)
//                    .offset(y: selectedCircle == 0 ? -25 : 0)
//                Circle()
//                    .fill(Color.white)
//                    .offset(y: selectedCircle == 1 ? -25 : 0)
//                Circle()
//                    .fill(Color.white)
//                    .offset(y: selectedCircle == 2 ? -25 : 0)
//            }
//            .padding()
            
            TabView(selection: $selectedCircle,
                    content:  {
                        Rectangle()
                            .foregroundColor(Color.red)
                            .tag(0)
                        
                        Rectangle()
                            .foregroundColor(Color.blue)
                            .tag(1)
                    
                        Rectangle()
                            .foregroundColor(Color.black)
                            .tag(2)
                        
                    }
            )
            .frame(height: 400)
            .tabViewStyle(PageTabViewStyle())
                
                
            
        }
        .onReceive(timer, perform: { value in
            //FOR TIMER
            /*
             currentDate = value
             */
            
            //FOR COUNTDOWN
            /*
             if counter < 1 {
                 finishedText = "Wow!"
             } else {
                 counter-=1
             }
             */
        
            //FOR DATE COUNTDOWN
            /*updateDate()*/
        
            //FOR ANIMATION
            withAnimation(.default) {
                selectedCircle = selectedCircle == 2 ? 0 : selectedCircle + 1
            }
            
            
        })
    }
}

struct Timers_OnReceiveBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        Timers_OnReceiveBootcamp()
    }
}
