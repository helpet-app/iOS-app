//
//  CancelDonePageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 17.02.2023.
//

import SwiftUI

struct CancelDonePageView<Content: View>: View {
    @Environment(\.dismiss) private var dismiss

    let title: String?

    let doneButtonIsEnabled: Bool

    @ViewBuilder let content: Content

    let onCancelTap: (() async -> Void)?

    let onDoneTap: () async -> Void

    init(title: String? = nil,
         doneButtonIsEnabled: Bool,
         @ViewBuilder content: () -> Content,
         onCancelTap: (() async -> Void)? = nil,
         onDoneTap: @escaping () async -> Void) {
        self.title = title
        self.doneButtonIsEnabled = doneButtonIsEnabled
        self.content = content()
        self.onCancelTap = onCancelTap
        self.onDoneTap = onDoneTap
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                content
                    .padding()
            }
            .textFieldStyle(RoundedTextFieldStyle())
            .frame(maxWidth: .infinity)
            .scrollDismissesKeyboard(.interactively)
            .interactiveDismissDisabled()
            .background(Color.Background.primary.ignoresSafeArea(.all))
            .navigationTitle(title ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CancelButtonView {
                        if let onCancelTap = onCancelTap {
                            await onCancelTap()
                        } else {
                            dismiss()
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    DoneButtonView(isEnabled: doneButtonIsEnabled) {
                        await onDoneTap()
                    }
                }
            }
        }
    }
}
