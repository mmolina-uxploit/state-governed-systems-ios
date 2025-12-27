//
//  SpaceXTDO.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import Foundation

struct SpaceXLaunchDTO: Decodable {
    let id: String
    let flightNumber: Int?
    let name: String
    let dateUTC: String?
    let dateUnix: TimeInterval?
    let dateLocal: String?
    let datePrecision: String?
    let upcoming: Bool?
    let autoUpdate: Bool?
    let tbd: Bool?
    let success: Bool?
    let failures: [Failure]?
    let details: String?
    
    let rocket: String?
    let cores: [Core]?
    let payloads: [String]?
    let launchpad: String?
    
    let crew: [String]?
    let ships: [String]?
    let capsules: [String]?
    
    let links: Links?
    let fairings: Fairings?
    
    struct Failure: Decodable {
        let time: Int?
        let altitude: Int?
        let reason: String?
    }
    
    struct Core: Decodable {
        let core: String?
        let flight: Int?
        let gridfins: Bool?
        let legs: Bool?
        let reused: Bool?
        let landingAttempt: Bool?
        let landingSuccess: Bool?
        let landingType: String?
        let landpad: String?
        
        enum CodingKeys: String, CodingKey {
            case core, flight, gridfins, legs, reused
            case landingAttempt = "landing_attempt"
            case landingSuccess = "landing_success"
            case landingType = "landing_type"
            case landpad
        }
    }
    
    struct Links: Decodable {
        let patch: Patch?
        let reddit: Reddit?
        let flickr: Flickr?
        let presskit: URL?
        let webcast: URL?
        let youtubeID: String?
        let article: URL?
        let wikipedia: URL?
        
        struct Patch: Decodable {
            let small: URL?
            let large: URL?
        }
        
        struct Reddit: Decodable {
            let campaign: URL?
            let launch: URL?
            let media: URL?
            let recovery: URL?
        }
        
        struct Flickr: Decodable {
            let small: [URL]?
            let original: [URL]?
        }
        
        enum CodingKeys: String, CodingKey {
            case patch, reddit, flickr, presskit, webcast, article, wikipedia
            case youtubeID = "youtube_id"
        }
    }
    
    struct Fairings: Decodable {
        let reused: Bool?
        let recoveryAttempt: Bool?
        let recovered: Bool?
        let ships: [String]?
        
        enum CodingKeys: String, CodingKey {
            case reused
            case recoveryAttempt = "recovery_attempt"
            case recovered
            case ships
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, success, failures, details, rocket, cores, payloads, launchpad, crew, ships, capsules, links, fairings
        case flightNumber = "flight_number"
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case upcoming, autoUpdate = "auto_update", tbd
    }
}
