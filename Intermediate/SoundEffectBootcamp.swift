//
//  SoundEffectBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 7/23/22.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    enum SoundsType: String{
        case tada
        case badum
    }
    
    func playSound(soundType: SoundsType){
        guard let url = Bundle.main.url(
                forResource: soundType.rawValue,
                withExtension:  ".mp3") else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("error=> \(error.localizedDescription)")
        }
    }
}

struct SoundEffectBootcamp: View {
    
    var body: some View {
        VStack(spacing: 50){
            Button(action:{
                SoundManager.instance.playSound(soundType: SoundManager.SoundsType.badum)
            }) {
                Text("Play Sound 1")
            }
            
            Button(action:{
                SoundManager.instance.playSound(soundType: SoundManager.SoundsType.badum)
            }) {
                Text("Play Sound 2")
            }
        }
    }
}

struct SoundEffectBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundEffectBootcamp()
    }
}
