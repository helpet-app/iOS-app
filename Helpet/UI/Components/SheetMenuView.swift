//
//  SheetMenuView.swift
//  Helpet
//
//  Created by Efim Nikitin on 26.01.2023.
//

import SwiftUI

struct SheetMenuView<Content: View, ViewModel: SheetMenuViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    @ViewBuilder let sheet: (ViewModel.SheetType) -> Content

    var body: some View {
        Menu {
            ForEach(viewModel.sheets, id: \.type.id) { sheet in
                Button {
                    viewModel.switchSheet(to: sheet.type)
                } label: {
                    Label(sheet.label, systemImage: sheet.imageName)
                }
            }
        } label: {
            Image(systemName: viewModel.imageName)
                .font(.body.weight(.bold))
        }
        .sheet(item: $viewModel.selectedSheet) { sheetType in
            sheet(sheetType)
        }
    }
}
