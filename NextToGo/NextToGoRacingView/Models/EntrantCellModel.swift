//
//  RacingCellModel.swift
//  NextToGo
//
//  Created by yacob kazal on 23/3/2025.
//

import Foundation
struct EntrantCellModel: Identifiable {
    let id: String
    let number: Int
    let silkURL: String?
    let last20Stars: String?
    let title: String
    let jockey: String?
    let trainer: String
    let racingCategory: RacingCategory
    let winPrice: Double
    let country: String
    let accessibilityLabel: String
}
