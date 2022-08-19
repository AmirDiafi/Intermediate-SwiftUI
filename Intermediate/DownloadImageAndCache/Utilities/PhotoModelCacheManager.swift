//
//  PhotoModelCacheManager.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/17/22.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager: ObservableObject {
    static var shared = PhotoModelCacheManager()
    private init() {}
    
    var cahces: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return cache
    }()
    
    func add(image: UIImage, key: String) {
        cahces.setObject(image, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return cahces.object(forKey: key as NSString)
    }
}
