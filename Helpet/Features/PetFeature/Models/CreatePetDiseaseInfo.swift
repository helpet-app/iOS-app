//
//  CreatePetDiseaseInfo.swift
//  Helpet
//
//  Created by Efim Nikitin on 10.06.2023.
//

import Foundation

struct CreatePetDiseaseInfo {
    var diseaseName: String = ""

    var comment: String?

    var gotSickOn: Date = Date()

    var recoveredOn: Date = Date()

    var alreadyRecovered: Bool = false
}
