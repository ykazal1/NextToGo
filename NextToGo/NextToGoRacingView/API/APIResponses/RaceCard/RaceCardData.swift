//
//  RaceCardData.swift
//  NextToGo
//
//  Created by yacob kazal on 24/3/2025.
//

import Foundation

struct RaceCardModel {
    
}
// MARK: - Data Container
struct RaceCardData: Decodable {
    let races: [String: Race]
    let entrants: [String: Entrant]
    let meetings: [String: Meeting]?
    let markets: [String: Market]?
    let priceFluctuations: [String: [Double]]?
    enum CodingKeys: String, CodingKey {
        case races, markets, entrants, meetings
        case priceFluctuations = "price_fluctuations"
    }
}
