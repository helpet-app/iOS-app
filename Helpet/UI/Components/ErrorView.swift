//
//  ErrorView.swift
//  Helpet
//
//  Created by Efim Nikitin on 06.06.2023.
//

import SwiftUI

struct ErrorView: View {
    let error: BasicError

    let onRetry: () async -> Void

    init(error: Error, onRetry: @escaping () async -> Void) {
        self.error = BasicError(from: error)
        self.onRetry = onRetry
    }

    var body: some View {
        VStack(spacing: DefaultViewConstants.Spacing.medium) {
            Image(systemName: imageNameFor(error: error))
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .foregroundColor(.Foreground.primary)

            Text(error.errorTitle)
                .font(.title3)
                .fontWeight(.bold)

            Text(error.localizedDescription)
                .font(.callout)
                .foregroundColor(.Foreground.quaternary)

            Button(Localizer.l10n(key: "ERROR_VIEW.RETRY_BUTTON_LABEL")) {
                Task {
                    await onRetry()
                }
            }
            .buttonStyle(CapsuleButtonStyle())
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Background.primary)
    }

    private func imageNameFor(error: BasicError) -> String {
        switch error {
        case .urlSessionError:
            return "antenna.radiowaves.left.and.right.slash"
        default:
            return "exclamationmark.bubble"
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: BasicError.unknownError) {

        }
    }
}
