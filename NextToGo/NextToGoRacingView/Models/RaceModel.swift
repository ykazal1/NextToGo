//
//  RaceModel.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation

struct RaceModel: Identifiable{
    var id: String
    let advertisedStart: Date
    let racingCategory: RacingCategory
    let title: String
    let subTitle: String
}
