//
//  VetProfilePageView.swift
//  Helpet
//
//  Created by Efim Nikitin on 09.02.2023.
//

import SwiftUI

struct VetProfilePageView: View {
    private let localizedConstants = LocalizedConstants()

    @StateObject private var viewModel: VetProfilePageViewModel

    @StateObject private var pageTabViewModel = VetProfileTabViewModel()

    @State private var newAppointmentSheetIsShown: Bool = false

    @State private var limitLines = true

    init(vet: Vet) {
        self._viewModel = StateObject(wrappedValue: VetProfilePageViewModel(vet: vet))
    }

    var avatar: some View {
        CachedImage(url: URL(string: viewModel.vet.avatarUrl))
            .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 300)
    }

    var tags: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.vet.tags) { tag in
                    TagView(caption: tag.name)
                }
            }
        }
    }

    var name: some View {
        Text(viewModel.vet.name)
            .font(.headline)
            .padding(.horizontal)
            .lineLimit(1)
    }

    @ViewBuilder
    var bio: some View {
        if let bio = viewModel.vet.bio {
            Text(bio)
                .foregroundColor(.Foreground.quaternary)
                .font(.system(.subheadline, design: .rounded).weight(.regular))
                .lineSpacing(DefaultViewConstants.Spacing.small)
                .lineLimit(limitLines ? 5 : nil)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.Background.secondary)
                .rounded()
                .onTapGesture {
                    limitLines.toggle()
                }
        }
    }

    var vetTariffList: some View {
        ListView(items: viewModel.vetTariffs.sorted(by: \.minPrice)) { vetTariff in
            VetTariffListRowView(vetTariff: vetTariff)
        } destination: { vetTariff in
            VetTariffPageView(vetTariff: vetTariff)
        }
        .fetchStatus(viewModel.tabsRequestStatuses[.tariffs], alignment: .top) {
            await viewModel.fetchVetTariffs()
        }
        .task {
            await viewModel.fetchVetTariffs()
        }
    }

    var vetContactList: some View {
        ListView(items: viewModel.vetContacts.sorted(by: \.name)) { vetContact in
            VetContactListRowView(vetContact: vetContact)
        } destination: { vetContact in
            VetContactPageView(vetContact: vetContact)
        }
        .fetchStatus(viewModel.tabsRequestStatuses[.contacts], alignment: .top) {
            await viewModel.fetchVetContacts()
        }
        .task {
            await viewModel.fetchVetContacts()
        }
    }

    var vetSchedule: some View {
        VStack {
            VetScheduleView(slots: viewModel.vetSchedule.sorted(by: \.timeSlot.startTime))
                .fetchStatus(viewModel.tabsRequestStatuses[.schedule], alignment: .top) {
                    await viewModel.fetchVetSchedule()
                }
                .task {
                    await viewModel.fetchVetSchedule()
                }

            Spacer()
        }
    }

    var cardInfo: some View {
        PageTabView(viewModel: pageTabViewModel) { tabType in
            switch tabType {
            case .tariffs: vetTariffList
            case .contacts: vetContactList
            case .schedule: vetSchedule
            }
        }
    }

    var createAppointmentButton: some View {
        Button {
            newAppointmentSheetIsShown = true
        } label: {
            Image(systemName: "heart.text.square")
                .font(.body.weight(.semibold))
        }
        .sheet(isPresented: $newAppointmentSheetIsShown) {
            CreateAppointmentPageView(vet: viewModel.vet)
        }
    }

    var body: some View {
        DismissSheet(title: localizedConstants.title) {
            VStack(alignment: .leading, spacing: DefaultViewConstants.Spacing.medium) {
                avatar

                tags

                name

                bio

                cardInfo
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    createAppointmentButton
                }
            }
        }
    }
}

extension VetProfilePageView {
    private struct LocalizedConstants {
        let title = Localizer.l10n(key: "VET_PROFILE_PAGE.TITLE")
    }
}

struct VetProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable:next all
        VetProfilePageView(vet: Vet(id: UUID(), name: "Иванов Петр Сергеевич", bio: "Опытный ветеринар, работающий в ветеринарной области уже более 20 лет. Он получил степень доктора ветеринарной медицины в Московском государственном университете и специализируется на обслуживании домашних животных.\n\nДоктор Иванов имеет опыт в различных областях ветеринарной медицины, включая хирургические операции, диагностику и лечение болезней животных. Он также имеет опыт работы с экзотическими животными, включая птиц и рептилий.\n\nДоктор Иванов ценит индивидуальный подход к уходу за животными, и он стремится помочь своим клиентам разобраться в их заботах и потребностях их питомцев. Он готов работать с каждым клиентом, чтобы найти лучшее решение для их животных.\n\nВ свободное время доктор Иванов занимается активными видами спорта, такими как бег и плавание. Он также любит проводить время со своими двумя собаками и кошкой.", avatarUrl: "https://static01.nyt.com/images/2012/09/11/science/11VETS_SPAN/11JPVETS-superJumbo.jpg", available: true, tags: [VetTag(id: UUID(), name: "Хирург")]))
    }
}
