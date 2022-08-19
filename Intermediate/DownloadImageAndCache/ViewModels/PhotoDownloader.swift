//
//  PhotoDownloader.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/17/22.
//

import Foundation
import SwiftUI
import Combine

class PhotoDwonloader: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var image : UIImage? = nil
    var cancellables = Set<AnyCancellable>()
    let url: String
    let imageKey: String
    
    var manager = PhotoModelCacheManager.shared
    
    init(url: String, imageKey: String) {
        self.url = url
        self.imageKey = imageKey
        getImage()
    }
    
    func getImage() {
        if let cachedImage = manager.get(key: imageKey) {
            self.image = cachedImage
            print("GOT FROM CACHE")
        } else {
            downloadImage()
            print("GOT FROM INTERNET")
        }
    }
    
    func downloadImage() {
        guard let url = URL(string: url) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { (data, response) -> UIImage? in
                return UIImage(data: data)
            }
            .sink {(completion) in
                print("completion \(completion)")
            } receiveValue: {[weak self] (image) in
                guard let self = self,
                      let image = image
                else {
                    return
                }
                
                self.image = image
                self.isLoading = false
                self.manager.add(image: image, key: self.imageKey)
            }
            .store(in: &cancellables)
    }
    
}
