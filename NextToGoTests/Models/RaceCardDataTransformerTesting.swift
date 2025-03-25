//
//  RaceCardDataTransformerTesting.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//


import Foundation
import Testing
@testable import NextToGo

@Suite
struct RaceCardDataTransformerTesting {

    @Test
    func testTransformsValidEntrants() {
        let market = Market(
            id: "UUID",
            raceID: "UUID",
            name: "Final Field",
            entrantIDs: ["UUID"]
        )
        let entrant = Entrant(
            id: "UUID",
            name: "Fast Horse",
            barrier: 3,
            number: 3,
            marketID: "some",
            isScratched: false,
            visible: false,
            barrierPosition: "",
            silkURL: "https://fakeimage.com/silk.png",
            formSummary: FormSummary(
                last20Starts: "x1234",
                riderOrDriver: "Jane Doe",
                trainerName: "Trainer A",
                bestTime: "22",
                handicapWeight: 55.5,
                entrantComment: "some"
            )
        )

        
        let race = Race(
            id: "UUID",
            meetingID: "UUID",
            name: "some race",
            number: 3,
            advertisedStart: TimeValue(seconds: 1_712_345_678),
            actualStart: TimeValue(seconds: 1_712_345_678),
            marketIDs: ["String"]
        )
        let meeting = Meeting(
            id: "UUID",
            name: "meeting name",
            categoryID: RacingCategory.horse.rawValue,
            country: "AUS"
        )
        
        let data = RaceCardData(
            races: ["UUID": race],
            entrants: ["UUID": entrant],
            meetings: ["UUID": meeting],
            markets: ["UUID": market],
            priceFluctuations: ["UUID" : [1.3, 1.4, 7.5]])

        let models = RaceCardDataTransformer.transform(data)

        #expect(models.count == 1)
        let model = models[0]
        #expect(model.id == "UUID")
        #expect(model.title.contains("Fast Horse"))
        #expect(model.jockey?.contains("Jane Doe") == true)
        #expect(model.trainer == "T: Trainer A")
        #expect(model.winPrice == 7.5)
        #expect(model.racingCategory == .horse)
        #expect(model.country == "AUS")
        #expect(model.accessibilityLabel.contains("Win Price is $7.5"))
    }

    @Test
    func testReturnsEmptyIfFinalFieldMissing() {
        let data = RaceCardData(
            races: [:],
            entrants: [:],
            meetings: [:],
            markets: [:],
            priceFluctuations: [:])

        let models = RaceCardDataTransformer.transform(data)
        #expect(models.isEmpty)
    }

    @Test
    func testFiltersScratchedEntrants() {
        let market = Market(
            id: "UUID",
            raceID: "UUID",
            name: "Final Field",
            entrantIDs: ["UUID"]
        )
        let scratchedEntrant = Entrant(
            id: "UUID",
            name: "Scratched One",
            barrier: 1,
            number: 1,
            marketID: "some",
            isScratched: true,
            visible: false,
            barrierPosition: "",
            silkURL: "https://fakeimage.com/silk.png",
            formSummary: nil
        )

        
        let race = Race(
            id: "UUID",
            meetingID: "UUID",
            name: "some race",
            number: 3,
            advertisedStart: TimeValue(seconds: 1_712_345_678),
            actualStart: TimeValue(seconds: 1_712_345_678),
            marketIDs: ["String"]
        )
        let meeting = Meeting(
            id: "UUID",
            name: "meeting name",
            categoryID: RacingCategory.horse.rawValue,
            country: "AUS"
        )
        
        let data = RaceCardData(
            races: [:],
            entrants: ["UUID": scratchedEntrant],
            meetings: ["UUID": meeting],
            markets: ["UUID": market],
            priceFluctuations: ["UUID" : [1.3, 1.4, 7.5]])

        let models = RaceCardDataTransformer.transform(data)
        #expect(models.isEmpty)
    }
}
