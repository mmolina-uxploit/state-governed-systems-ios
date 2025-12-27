//
//  ImageLoader.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private static var cache = NSCache<NSURL, UIImage>()
    
    private var url: URL?
    
    init(url: URL?) {
        self.url = url
        load()
    }
    
    private func load() {
        guard let url = url else { return }
        
        // Revisar cache
        if let cached = ImageLoader.cache.object(forKey: url as NSURL) {
            self.image = cached
            return
        }
        
        // Descargar
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data) {
                    ImageLoader.cache.setObject(uiImage, forKey: url as NSURL)
                    await MainActor.run {
                        self.image = uiImage
                    }
                }
            } catch {
                print("Error cargando imagen: \(error)")
            }
        }
    }
}
