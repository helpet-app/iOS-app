//
//  PickerPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import SwiftUI

struct PickerPageView<SelectedItemView: View, ItemRowView: View, ViewModel: PickerPageViewModel>: View {
    private let localizedConstants = LocalizedConstants()

    let label: String

    @Binding var selectedItem: ViewModel.Item?

    @ObservedObject var viewModel: ViewModel

    @ViewBuilder let selectedItemView: (ViewModel.Item) -> SelectedItemView

    @ViewBuilder let itemRowView: (ViewModel.Item) -> ItemRowView

    var itemList: some View {
        Group {
            if viewModel.items.isEmpty {
                EmptyListView()
            } else {
                List {
                    Picker(selection: $selectedItem) {
                        Text(localizedConstants.notChosenLabel)
                            .tag(ViewModel.Item?(nil))

                        ForEach(viewModel.items) { item in
                            itemRowView(item)
                                .tag(ViewModel.Item?(item))
                        }
                    } label: {
                        Text(label)
                            .font(.footnote)
                    }
                    .font(.callout)
                    .listRowBackground(Color.Background.secondary)
                    .pickerStyle(.inline)
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(Color.Background.primary)
        .fetchStatus(viewModel.requestStatus) {
            await viewModel.fetchItems()
        }
        .task {
            await viewModel.fetchItems()
        }
    }

    var pickerLabel: some View {
        Group {
            if let selectedItem = selectedItem {
                selectedItemView(selectedItem)
            } else {
                Text(localizedConstants.notChosenLabel)
                    .foregroundColor(.Foreground.quinary)
            }
        }
        .font(.subheadline)
        .frame(alignment: .leading)
        .modifier(NavigationLinkModifier())
        .padding()
        .background(Color.Background.tertiary)
        .rounded()
    }

    var body: some View {
        NavigationLink {
            itemList
        } label: {
            pickerLabel
        }
        .buttonStyle(.plain)
        .foregroundColor(.Foreground.primary)
    }
}

extension PickerPageView {
    private struct LocalizedConstants {
        let notChosenLabel = Localizer.l10n(key: "PICKER_PAGE_VIEW.NOT_CHOSEN_LABEL")
    }
}
