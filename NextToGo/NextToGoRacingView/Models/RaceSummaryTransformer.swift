//
//  RaceSummaryTransformer.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation

enum RaceSummaryTransformer {
    /// Converts a `RaceSummary` object into a `RaceModel` for UI consumption.
    ///
    /// This function extracts and formats the relevant details from a `RaceSummary`,
    /// including the race ID, category, title, subtitle (distance and track condition),
    /// and advertised start time as a `Date`.
    ///
    /// - Parameter race: The `RaceSummary` to transform.
    /// - Returns: A `RaceModel` containing formatted race details ready for display.
    static func transform(_ race: RaceSummary) -> RaceModel {
        let id = race.raceID
        let racingCategory = RacingCategory(rawValue: race.categoryID) ?? .unknown
        let title = "\(race.meetingName) R\(race.raceNumber)"
        let subTitle = "\(race.raceForm?.distanceString ?? "")"
        let advertisedStart = Date(timeIntervalSince1970: TimeInterval(race.advertisedStart.seconds))
        return RaceModel(
            id: id,
            advertisedStart: advertisedStart,
            racingCategory: racingCategory,
            title: title,
            subTitle: subTitle
        )
    }
}

private extension RaceForm {
    var distanceString: String {
        "\(distance)\(distanceType.shortName) \(trackCondition?.name ?? "")"
    }
}
