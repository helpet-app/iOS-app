//
//  SpinnerProgressViewStyle.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.05.2023.
//

import SwiftUI

struct SpinnerProgressViewStyle: ProgressViewStyle {
    @State private var isSpinning = false

    func makeBody(configuration: Configuration) -> some View {
        return Circle()
            .trim(from: 1/3)
            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .foregroundColor(.Foreground.primary)
            .frame(width: 20, height: 20)
            .rotationEffect(.degrees(isSpinning ? 360 : 0))
            .animation(.linear(duration: 0.75).repeatForever(autoreverses: false), value: isSpinning)
            .onAppear {
                self.isSpinning = true
            }
    }
}
