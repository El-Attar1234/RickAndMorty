//
//  AsyncImageView.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String
    
    var body: some View {
        VStack {
            if let image = checkCache() {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                AsyncImage(url: URL(string: url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .onAppear {
                                cacheImage(image: image)
                            }
                    case .failure:
                        Image("subCardSquarePlaceHolder")
                            .resizable()
                            .scaledToFill()
                        
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
    }
    
    private func checkCache() -> UIImage? {
        ImageCache.shared.image(forKey: url)
    }
    
    private func cacheImage(image: Image) {
        // Convert SwiftUI Image to UIImage for caching
        let renderer = ImageRenderer(content: image)
        if let uiImage = renderer.uiImage {
            ImageCache.shared.setImage(uiImage, forKey: url)
        }
    }
}
