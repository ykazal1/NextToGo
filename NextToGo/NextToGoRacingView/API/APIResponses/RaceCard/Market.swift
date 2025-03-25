//
//  Market.swift
//  NextToGo
//
//  Created by yacob kazal on 24/3/2025.
//




struct Market: Decodable {
    let id: String
    let raceID: String
    let name: String
    let entrantIDs: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case raceID = "race_id"
        case entrantIDs = "entrant_ids"
    }
}
