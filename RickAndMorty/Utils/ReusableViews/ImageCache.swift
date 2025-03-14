//
//  ImageCache.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 14/03/2025.
//
import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private let cache: NSCache<NSString, UIImage>
    
    private init() {
        cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // Maximum number of images to cache
        cache.totalCostLimit = 50 * 1024 * 1024 // 50 MB
    }
    
    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
