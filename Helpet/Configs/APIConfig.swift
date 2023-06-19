//
//  APIConfig.swift
//  Helpet
//
//  Created by Efim Nikitin on 14.06.2023.
//

import Foundation

enum APIConfig {
    static let baseURL = "http://backend.helppet.website:8080"

    enum Service {
        static let accountServiceURL = APIConfig.baseURL + "/account-service/api/v1"

        static let vetServiceURL = APIConfig.baseURL + "/vet-service/api/v1"

        static let petServiceURL = APIConfig.baseURL + "/pet-service/api/v1"

        static let appointmentServiceURL = APIConfig.baseURL + "/appointment-service/api/v1"

        static let newsFeedServiceURL = APIConfig.baseURL + "/news-feed-service/api/v1"
    }
}
