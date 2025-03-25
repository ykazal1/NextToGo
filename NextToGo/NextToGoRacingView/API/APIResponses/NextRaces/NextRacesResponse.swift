//
//  NextRacesResponse.swift
//  NextToGo
//
//  Created by yacob kazal on 21/3/2025.
//

import Foundation

// MARK: - API Response Model
struct NextRacesResponse: Decodable {
    let data: RaceData
}

// MARK: - Race Data Model
struct RaceData: Decodable {
    let raceSummaries: [String: RaceSummary]

    enum CodingKeys: String, CodingKey {
        case raceSummaries = "race_summaries"
    }
}
// MARK: - Race Summary Model
struct RaceSummary: Decodable {
    let raceID: String
    let raceNumber: Int
    let meetingID: String
    let meetingName: String
    let categoryID: String
    let advertisedStart: AdvertisedStart
    let raceForm: RaceForm?

    enum CodingKeys: String, CodingKey {
        case raceID = "race_id"
        case raceNumber = "race_number"
        case meetingName = "meeting_name"
        case meetingID = "meeting_id"
        case categoryID = "category_id"
        case advertisedStart = "advertised_start"
        case raceForm = "race_form"
    }
}

// MARK: - Advertised Start Model
struct AdvertisedStart: Decodable {
    let seconds: Int
}

// MARK: - Race Form Model
struct RaceForm: Decodable {
    let distance: Int
    let distanceType: DistanceType
    let trackCondition: TrackCondition?

    enum CodingKeys: String, CodingKey {
        case distance
        case distanceType = "distance_type"
        case trackCondition = "track_condition"
    }
}

// MARK: - Distance Type Model
struct DistanceType: Decodable {
    let shortName: String

    enum CodingKeys: String, CodingKey {
        case shortName = "short_name"
    }
}

// MARK: - Track Condition Model
struct TrackCondition: Decodable {
    let name: String
}
