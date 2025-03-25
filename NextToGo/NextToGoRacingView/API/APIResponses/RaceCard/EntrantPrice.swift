//
//  EntrantPrice.swift
//  NextToGo
//
//  Created by yacob kazal on 24/3/2025.
//

import Foundation

struct EntrantPrice: Decodable {
    let entrantID: String
    let odds: Double?

    enum CodingKeys: String, CodingKey {
        case entrantID = "entrant_id"
        case odds
    }
}
