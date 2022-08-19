//
//  Photo.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/17/22.
//

import SwiftUI

struct Photo: View {
    var url: String? = nil
    @StateObject var photoDwonloader: PhotoDwonloader
    
        
    init(url: String) {
        _photoDwonloader = StateObject(
            wrappedValue: PhotoDwonloader(url: url, imageKey: "\(url)"))
    }
    
    var body: some View {
        ZStack{
            if let image = photoDwonloader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
            } else if photoDwonloader.isLoading {
                ProgressView()
            } else {
                Image(systemName: "flame.fill")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 20, height: 20)
            }
        }
        .frame(width: 80, height: 80)
        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
        .cornerRadius(80)
        .padding(.trailing, 5)
    }
}

struct Photo_Previews: PreviewProvider {
    static var previews: some View {
        Photo(url: "")
    }
}
