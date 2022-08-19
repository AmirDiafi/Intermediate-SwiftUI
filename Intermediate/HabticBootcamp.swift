//
//  HabticBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/24/22.
//

import SwiftUI

class HabticManager{
    static let instace = HabticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}

struct HabticBootcamp: View {
    var body: some View {
        VStack{
            Button(action: {
                HabticManager.instace.notification(type: .success)
            }){
                Text("Notification success!")
            }
            
            Button(action: {
                HabticManager.instace.notification(type: .warning)
            }){
                Text("Notification warning!")
            }
        
            Button(action: {
                HabticManager.instace.notification(type: .error)
            }){
                Text("Notification error!")
            }
            
            Divider()
            
            Button(action: {
                HabticManager.instace.impact(style: .heavy)
            }){
                Text("Habtic heavy!")
            }
            Button(action: {
                HabticManager.instace.impact(style: .light)
            }){
                Text("Habtic light!")
            }
            Button(action: {
                HabticManager.instace.impact(style: .medium)
            }){
                Text("Habtic meduim!")
            }
            Button(action: {
                HabticManager.instace.impact(style: .rigid)
            }){
                Text("Habtic rigid!")
            }
            Button(action: {
                HabticManager.instace.impact(style: .soft)
            }){
                Text("Habtic soft!")
            }
        }
        .font(.title)
    }
}

struct HabticBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HabticBootcamp()
    }
}
