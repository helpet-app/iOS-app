//
//  FetchStatusModifier.swift
//  Helpet
//
//  Created by Efim Nikitin on 06.06.2023.
//

import SwiftUI

struct FetchStatusModifier: ViewModifier {
    let fetchStatus: RequestStatus?

    let alignment: VerticalAlignment

    let onRetry: () async -> Void

    var progressView: some View {
        VStack {
            if alignment == .bottom {
                Spacer()
            }

            ProgressView()
                .padding(.vertical, 40)

            if alignment == .top {
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Background.primary)
    }

    func body(content: Content) -> some View {
        Group {
            switch fetchStatus {
            case .none, .loading:
                progressView
            case .failure(let error):
                ErrorView(error: error) {
                    await onRetry()
                }
            case .success:
                content
            }
        }
    }
}

extension View {
    func fetchStatus(_ fetchStatus: RequestStatus?, alignment: VerticalAlignment = .center, onRetry: @escaping () async -> Void) -> some View {
        modifier(FetchStatusModifier(fetchStatus: fetchStatus, alignment: alignment, onRetry: onRetry))
    }
}
