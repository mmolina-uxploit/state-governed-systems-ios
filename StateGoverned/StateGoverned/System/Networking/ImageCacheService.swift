//
//  ImageCacheService.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private init() {}

    private var cache = NSCache<NSURL, UIImage>()

    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return }
        cache.setObject(image, forKey: url as NSURL)
    }
}
