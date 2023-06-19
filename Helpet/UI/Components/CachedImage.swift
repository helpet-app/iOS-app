//
//  CachedImage.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.05.2023.
//

import SwiftUI

struct CachedImage<Content: View>: View {
    @StateObject private var cachedImageViewModel = CachedImageViewModel()

    let url: URL?

    let loadingView: () -> Content

    let failureView: (() -> Content)?

    init(url: URL?, loadingView: @escaping () -> Content = { EmptyView() }, failureView: (() -> Content)? = nil) {
        self.url = url
        self.loadingView = loadingView
        self.failureView = failureView
    }

    var emptyImage: some View {
        EmptyImageView()
    }

    var body: some View {
        if let imageUrl = url {
            VStack {
                switch cachedImageViewModel.status {
                case .notStarted:
                    loadingView()
                case .loading:
                    loadingView()
                case .success(let data):
                    if let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    } else {
                        emptyImage
                    }
                case .failure:
                    if let failureView = failureView {
                        failureView()
                    } else {
                        CachedImage(url: url, loadingView: loadingView, failureView: failureView)
                    }
                }
            }
            .task {
                await cachedImageViewModel.loadImageIfNeeded(url: imageUrl)
            }
        } else {
            emptyImage
        }
    }
}

struct CachedImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedImage(url: URL(string: ""))
    }
}
