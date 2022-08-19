//
//  CashesBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/13/22.
//

import SwiftUI

class CachesFileManager {
    static let shared = CachesFileManager()
    private init() {}
    
    let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 1
        cache.totalCostLimit = 1240 * 1240 * 100 // 100mb
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("ADDED")
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("DELETED")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
}

class CachesViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var imageName: String = "prfl"
    var manager = CachesFileManager.shared
    
    init() {
        getImage()
    }
    
    func getImage() {
        image = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = image else {
            print("there is no image passed!")
            return
        }
        manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        manager.remove(name: imageName)
        cachedImage = nil
    }
    
    func getImageFromCache() {
        guard let image: UIImage = manager.get(name: imageName) else {
            print("no image found!")
            return
        }
        
        cachedImage = image
    }
}

struct CashesBootcamp: View {
    @StateObject var vm = CachesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Text("Original Image:")
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                }
                if let cachedImage = vm.cachedImage {
                    Text("Cached Image:")
                    Image(uiImage: cachedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                }
                HStack {
                    Button(action:{
                        vm.saveToCache()
                    }) {
                        Text("save".uppercased())
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.vertical)
                    }
                    Button(action:{
                        vm.getImageFromCache()
                    }) {
                        Text("get".uppercased())
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.vertical)
                    }
                    Button(action:{
                        vm.removeFromCache()
                    }) {
                        Text("delete".uppercased())
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding(.vertical)
                    }
                }
                Spacer()
            }
            .navigationTitle("Caches")
        }
    }
}

struct CashesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CashesBootcamp()
    }
}
