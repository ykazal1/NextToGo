//
//  Entrant.swift
//  NextToGo
//
//  Created by yacob kazal on 24/3/2025.
//

import Foundation

// MARK: - Entrant
struct Entrant: Decodable, Identifiable {
    let id: String
    let name: String?
    let barrier: Int?
    let number: Int?
    let marketID: String?
    var isScratched: Bool?
    let visible: Bool?
    let barrierPosition: String?
    let silkURL: String?
    let formSummary: FormSummary?

    enum CodingKeys: String, CodingKey {
        case id, name, barrier, number, visible
        case marketID = "market_id"
        case barrierPosition = "barrier_position"
        case silkURL = "silk_url"
        case formSummary = "form_summary"
        case isScratched = "is_scratched"
    }
}
