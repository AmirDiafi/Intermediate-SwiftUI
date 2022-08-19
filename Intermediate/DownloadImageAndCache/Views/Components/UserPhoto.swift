//
//  UserPhoto.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/16/22.
//

import SwiftUI

struct UserPhoto: View {
    var itemData: PhotoModel?
    var body: some View {
        HStack {
            Photo(url: itemData?.url ?? "https://via.placeholder.com/600/92c952")
            VStack(alignment: .leading){
                Text(itemData?.title ?? "This is the Title")
                    .font(.headline)
                    .lineLimit(2)
                
                Text(itemData?.url ?? "And this is the details")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct UserPhoto_Previews: PreviewProvider {
    static var previews: some View {
        UserPhoto()
            .previewLayout(.sizeThatFits)
    }
}
