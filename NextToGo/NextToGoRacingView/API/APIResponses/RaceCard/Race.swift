//
//  Race.swift
//  NextToGo
//
//  Created by yacob kazal on 24/3/2025.
//

import Foundation

// MARK: - Race
struct Race: Decodable {
    let id: String
    let meetingID: String
    let name: String
    let number: Int
    let advertisedStart: TimeValue
    let actualStart: TimeValue?
    let marketIDs: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, number
        case meetingID = "meeting_id"
        case advertisedStart = "advertised_start"
        case actualStart = "actual_start"
        case marketIDs = "market_ids"
    }
}

struct TimeValue: Decodable {
    let seconds: Int
}
