//
//  FamilyPageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 24.01.2023.
//

import SwiftUI

struct FamilyPageView: View {
    @StateObject private var viewModel = FamilyPageViewModel()

    @StateObject private var pageTabViewModel = FamilyPageTabViewModel()

    @StateObject private var sheetMenuViewModel = FamilyPageSheetMenuViewModel()

    var petList: some View {
        ListView(items: viewModel.pets.sorted(by: \.name), style: .link) { pet in
            PetListRowView(pet: pet)
        } destination: { pet in
            PetProfilePageView(pet: pet)
                .environmentObject(viewModel)
        }
        .fetchStatus(viewModel.tabsRequestStatuses[.pets]) {
            await viewModel.fetchPets()
        }
        .task {
            await viewModel.fetchPets()
        }
        .refreshable {
            await viewModel.fetchPets()
        }
    }

    var familyMemberList: some View {
        ListView(items: viewModel.familiesMembers.sorted(by: \.name), style: .link) { familyMember in
            FamilyMemberListRowView(familyMember: familyMember)
        } destination: { _ in
            NotImplementedYetView()
        }
        .fetchStatus(viewModel.tabsRequestStatuses[.familiesMembers]) {
            await viewModel.fetchFamiliesMembers()
        }
        .task {
            await viewModel.fetchFamiliesMembers()
        }
        .refreshable {
            await viewModel.fetchFamiliesMembers()
        }
    }

    var familyList: some View {
        ListView(items: viewModel.families.sorted(by: \.name), style: .link) { family in
            FamilyListRowView(family: family)
        } destination: { _ in
            NotImplementedYetView()
        }
        .fetchStatus(viewModel.tabsRequestStatuses[.families]) {
            await viewModel.fetchFamilies()
        }
        .task {
            await viewModel.fetchFamilies()
        }
        .refreshable {
            await viewModel.fetchFamilies()
        }
    }

    var addButton: some View {
        SheetMenuView(viewModel: sheetMenuViewModel) { sheetType in
            switch sheetType {
            case .addPet: CreatePetPageView().environmentObject(viewModel)
            case .addFamilyMember: NotImplementedYetView()
            case .addFamily: NotImplementedYetView()
            }
        }
    }

    var body: some View {
        CarouselView(viewModel: pageTabViewModel) {
            petList
                .padding(.horizontal)
                .tag(FamilyPageTabViewModel.TabType.pets)

            familyMemberList
                .padding(.horizontal)
                .tag(FamilyPageTabViewModel.TabType.familiesMembers)

            familyList
                .padding(.horizontal)
                .tag(FamilyPageTabViewModel.TabType.families)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton
            }
        }
    }
}

struct FamilyPageView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
