//
//  RaceCardDataTransformer.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

enum RaceCardDataTransformer {
    /// Transforms raw `RaceCardData` into an array of `EntrantCellModel` suitable for UI rendering.
    ///
    /// This function filters for entrants in the "Final Field" market that are not scratched,
    /// determines the racing category and country from the associated meeting, and constructs
    /// accessible display data for each entrant including price, title, and metadata.
    ///
    /// - Parameter data: The raw `RaceCardData` object containing all race information.
    /// - Returns: An array of `EntrantCellModel` representing the prepared entrants for display.
    static func transform(_ data: RaceCardData) -> [EntrantCellModel] {
        let finalFieldMarket = data.markets?.values.first{$0.name == "Final Field"}
        let entrantIDs = finalFieldMarket?.entrantIDs ?? []
        let entrants = entrantIDs.compactMap { data.entrants[$0] }.filter({!($0.isScratched ?? false)})
        let mainRaceMeetingID = data.races.values.first?.meetingID ?? ""
        let mainRaceMeeting = data.meetings?[mainRaceMeetingID]

        let racingCategory = RacingCategory(rawValue: mainRaceMeeting?.categoryID ?? "") ?? .unknown
        let meetingCountry = mainRaceMeeting?.country ?? "Unknown"
        return entrants.map {
            let winPrice = data.priceFluctuations?[$0.id]?.last ?? 0
            let accessibilityJockey  = $0.accessibilityJockey != nil ? ", \($0.accessibilityJockey ?? "")" : ""
            let accessibilityLabel = "\($0.accessibilityTitle)\(accessibilityJockey), \($0.accessibilityTrainer). Win Price is $\(winPrice)"
            return EntrantCellModel(
                id: $0.id,
                number: $0.number ?? 0,
                silkURL: $0.silkURL,
                last20Stars: $0.last20Starts,
                title: $0.title,
                jockey: $0.jockey,
                trainer: $0.trainer,
                racingCategory: racingCategory,
                winPrice: winPrice,
                country: meetingCountry,
                accessibilityLabel: accessibilityLabel
            )
        }
    }
}

private extension Entrant {
    
    var last20Starts: String? {
        guard let last20StartsSuffix = formSummary?.last20Starts?.suffix(5) else{
            return nil
        }
        return String(last20StartsSuffix)
    }
    var title: String {
        guard let number,
              let name else {
            Logger.log("❌ Entrant.title return guard failed, number: \(number ?? -1), name: \(name ?? "")", level: .error)
            return ""
        }
        var title = "\(number). \(name)"
        if let barrier {
            title += " (\(barrier))"
        }
        return title
    }
    
    var accessibilityTitle: String {
        guard let number,
              let name else {
            Logger.log("❌ Entrant.title return guard failed, number: \(number ?? -1), name: \(name ?? "")", level: .error)
            return ""
        }
        var title = "number:\(number), Name: \(name)"
        if let barrier {
            title += ", barrier: \(barrier)"
        }
        return title
    }

    var jockey: String? {
        guard let riderOrDriver = formSummary?.riderOrDriver, !riderOrDriver.isEmpty else {
            return nil
        }
        var string = "J: \(riderOrDriver)"
        if let handicapWeight = formSummary?.handicapWeight, handicapWeight > 0 {
            string += " \(handicapWeight) kg"
        }
        return string
    }

    var accessibilityJockey: String? {
        guard let riderOrDriver = formSummary?.riderOrDriver, !riderOrDriver.isEmpty else {
            return nil
        }
        var string = "Jockey: \(riderOrDriver)"
        if let handicapWeight = formSummary?.handicapWeight, handicapWeight > 0 {
            string += "handicapWeight: \(handicapWeight) kg"
        }
        return string
    }

    var trainer: String {
        "T: \(formSummary?.trainerName ?? "")"
    }

    var accessibilityTrainer: String {
        "Trainer: \(formSummary?.trainerName ?? "")"
    }
}
