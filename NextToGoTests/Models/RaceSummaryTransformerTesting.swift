//
//  RaceSummaryTransformerTesting.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//


import Foundation
import Testing
@testable import NextToGo

@Suite
struct RaceSummaryTransformerTesting {

    @Test
    func testTransformWithValidRaceSummary() {
        let summary = RaceSummary(
            raceID: "123",
            raceNumber: 7,
            meetingID: "someId",
            meetingName: "Testville",
            categoryID: RacingCategory.horse.rawValue,
            advertisedStart: AdvertisedStart(
                seconds: 1_712_345_678
            ),
            raceForm: RaceForm(
                distance: 1200,
                distanceType: DistanceType(
                    shortName: "m"
                ),
                trackCondition: TrackCondition(name: "Soft")
            )
        )

        let model = RaceSummaryTransformer.transform(summary)

        #expect(model.id == "123")
        #expect(model.title == "Testville R7")
        #expect(model.subTitle == "1200m Soft")
        #expect(model.racingCategory == .horse)
        #expect(model.advertisedStart == Date(timeIntervalSince1970: 1_712_345_678))
    }

    @Test
    func testTransformWithMissingRaceForm() {
        let summary = RaceSummary(
            raceID: "456",
            raceNumber: 1,
            meetingID: "someId",
            meetingName: "Nowhere",
            categoryID: "invalid-category",
            advertisedStart: .init(seconds: 1_712_345_999),
            raceForm: nil
        )

        let model = RaceSummaryTransformer.transform(summary)

        #expect(model.id == "456")
        #expect(model.title == "Nowhere R1")
        #expect(model.subTitle == "")
        #expect(model.racingCategory == .unknown)
        #expect(model.advertisedStart == Date(timeIntervalSince1970: 1_712_345_999))
    }
}
