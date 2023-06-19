//
//  CachedImageViewModel.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

class CachedImageViewModel: ObservableObject {
    @Published private(set) var status: Status = .notStarted

    @MainActor
    func loadImageIfNeeded(url: URL) async {
        guard case .notStarted = status else { return }

        self.status = .loading

        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad))
            self.status = .success(data: data)
        } catch {
            self.status = .failure(error: error)
        }
    }
}

extension CachedImageViewModel {
    enum Status {
        case notStarted
        case loading
        case success(data: Data)
        case failure(error: Error)
    }
}
