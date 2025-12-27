//
//  Launch.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import Foundation

struct Launch: Identifiable, Equatable {
    let id: UUID
    let flightNumber: Int
    let name: String
    let date: Date
    let datePrecision: String
    let wasSuccessful: Bool?
    let details: String?
    let imageURL: URL?
    let webcastURL: URL?
    let articleURL: URL?
    let wikipediaURL: URL?
    
    // Información extendida
    let rocket: String?
    let cores: [Core]
    let payloads: [String]
    let fairings: Fairings?
    let failures: [Failure]
    
    init(
        id: UUID,
        flightNumber: Int,
        name: String,
        date: Date,
        datePrecision: String,
        wasSuccessful: Bool? = nil,
        details: String? = nil,
        imageURL: URL? = nil,
        webcastURL: URL? = nil,
        articleURL: URL? = nil,
        wikipediaURL: URL? = nil,
        rocket: String? = nil,
        cores: [Core] = [],
        payloads: [String] = [],
        fairings: Fairings? = nil,
        failures: [Failure] = []
    ) {
        self.id = id
        self.flightNumber = flightNumber
        self.name = name
        self.date = date
        self.datePrecision = datePrecision
        self.wasSuccessful = wasSuccessful
        self.details = details
        self.imageURL = imageURL
        self.webcastURL = webcastURL
        self.articleURL = articleURL
        self.wikipediaURL = wikipediaURL
        self.rocket = rocket
        self.cores = cores
        self.payloads = payloads
        self.fairings = fairings
        self.failures = failures
    }
}

// Subestructuras para Launch
struct Core: Equatable {
    let coreID: String?
    let flight: Int?
    let reused: Bool?
    let landingAttempt: Bool?
    let landingSuccess: Bool?
    let landingType: String?
}

struct Fairings: Equatable {
    let reused: Bool?
    let recoveryAttempt: Bool?
    let recovered: Bool?
}

struct Failure: Equatable {
    let time: Int?
    let altitude: Int?
    let reason: String?
}
