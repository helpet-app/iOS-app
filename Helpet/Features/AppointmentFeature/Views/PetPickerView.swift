//
//  PetPickerView.swift
//  Helpet
//
//  Created by Efim Nikitin on 18.06.2023.
//

import SwiftUI

struct PetPickerView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel = PetPickerViewModel()

    @Binding var selectedPet: Pet?

    var body: some View {
        PickerPageView(label: localizedConstants.pickerLabel, selectedItem: $selectedPet, viewModel: viewModel) { pet in
            Text(pet.name)
        } itemRowView: { pet in
            Text(pet.name)
        }
    }
}

extension PetPickerView {
    private struct LocalizedConstants {
        let pickerLabel = Localizer.l10n(key: "PET_PICKER.PICKER_LABEL")
    }
}

struct PetPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PetPickerView(selectedPet: .constant(nil))
        }
    }
}
