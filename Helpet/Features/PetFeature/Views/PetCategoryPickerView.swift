//
//  PetCategoryPickerView.swift
//  Helpet
//
//  Created by Efim Nikitin on 07.06.2023.
//

import SwiftUI

struct PetCategoryPickerView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel = PetCategoryPickerViewModel()

    @Binding var selectedCategory: PetCategory?

    var body: some View {
        PickerPageView(label: localizedConstants.pickerLabel, selectedItem: $selectedCategory, viewModel: viewModel) { petCategory in
            Text(petCategory.name)
        } itemRowView: { petCategory in
            Text(petCategory.name)
        }
    }
}

extension PetCategoryPickerView {
    private struct LocalizedConstants {
        let pickerLabel = Localizer.l10n(key: "PET_CATEGORY_PICKER.PICKER_LABEL")
    }
}

struct PetCategoryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PetCategoryPickerView(selectedCategory: .constant(nil))
        }
    }
}
