//
//  CachedAsyncImageView.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import SwiftUI

struct CachedAsyncImageView: View {
    @StateObject private var loader: ImageLoader
    
    init(url: URL?) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
        }
    }
}
