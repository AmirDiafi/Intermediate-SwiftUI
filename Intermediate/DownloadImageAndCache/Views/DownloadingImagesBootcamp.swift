//
//  DownloadingImagesBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/14/22.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    @StateObject var vm = DownloadImagesViewModel.instance
    
    var body: some View {
        NavigationView {
            ZStack {
                if let data = vm.data {
                    List {
                        ForEach(data) { (item) in
                            UserPhoto(itemData: item)
                        }
                    }
                    .listStyle(PlainListStyle())
                } else if vm.isLoading {
                    Text("Loading...")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("No data to show")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Download Images")
        }
    }
}

struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}
