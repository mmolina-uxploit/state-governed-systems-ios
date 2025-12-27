//
//  CachedAsyncImage.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import SwiftUI

struct CachedAsyncImage<Content: View>: View {
    let url: URL?
    let content: (Image) -> Content
    let placeholder: () -> Content

    @State private var uiImage: UIImage?

    var body: some View {
        Group {
            if let uiImage {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
                    .task {
                        await loadImage()
                    }
            }
        }
    }

    private func loadImage() async {
        guard let url else { return }

        // 1. Revisar si ya está en cache
        if let cached = ImageCache.shared.image(for: url) {
            uiImage = cached
            return
        }

        // 2. Descargar desde red
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                ImageCache.shared.insertImage(image, for: url)
                uiImage = image
            }
        } catch {
            print("Error cargando imagen: \(error)")
        }
    }
}
