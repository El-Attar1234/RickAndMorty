//
//  AsyncImageView.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//

import SwiftUI
import UIKit

//struct AsyncImageView: View {
//    let url: String
//    let size: CGFloat
//    
//    var body: some View {
//        AsyncImage(url: URL(string: url)) { phase in
//            switch phase {
//            case .empty:
//                ProgressView()
//                    .frame(width: size, height: size)
//            case .success(let image):
//                image
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: size, height: size)
//                    .cornerRadius(8)
//            case .failure:
//                Rectangle()
//                    .fill(Color.gray.opacity(0.3))
//                    .frame(width: size, height: size)
//                    .cornerRadius(8)
//            @unknown default:
//                EmptyView()
//            }
//        }
//    }
//}
struct AsyncImageView: View {
    let url: String
    let size: CGFloat
    
    @State private var cachedImage: UIImage?
    
    var body: some View {
        VStack {
            if let image = cachedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
//                    .frame(width: size, height: size)
//                    .cornerRadius(8)
            } else {
                AsyncImage(url: URL(string: url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: size, height: size)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
//                            .frame(width: size, height: size)
//                            .cornerRadius(8)
                            .onAppear {
                                cacheImage(image: image)
                            }
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
//                            .frame(width: size, height: size)
//                            .cornerRadius(8)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
        .onAppear {
            checkCache()
        }
    }
    
    private func checkCache() {
        if let cached = ImageCache.shared.image(forKey: url) {
            cachedImage = cached
        }
    }
    
    private func cacheImage(image: Image) {
        // Convert SwiftUI Image to UIImage for caching
        let renderer = ImageRenderer(content: image)
        if let uiImage = renderer.uiImage {
            ImageCache.shared.setImage(uiImage, forKey: url)
            cachedImage = uiImage
        }
    }
}

class ImageCache {
    static let shared = ImageCache()
    
    private let cache: NSCache<NSString, UIImage>
    
    private init() {
        cache = NSCache<NSString, UIImage>()
        // Optional: Configure cache limits
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
