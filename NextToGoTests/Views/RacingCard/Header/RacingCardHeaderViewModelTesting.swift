//
//  RacingCardHeaderViewModelTesting.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation
import Testing
@testable import NextToGo

@Suite
struct RacingCardHeaderViewModelTesting {

    private let mockModel = RacingCardHeaderModel(
        racingCategory: .horse,
        title: "Race 5",
        subTitle: "1200m",
        advertisedStart: Date().addingTimeInterval(120)
    )

    @Test
    func titleAndSubtitleAreExposedCorrectly() {
        let vm = RacingCardHeaderViewModel(model: mockModel)

        #expect(vm.title == "Race 5")
        #expect(vm.subtitle == "1200m")
    }

    @Test
    func imageResourceIsCorrectForCategory() {
        let vm = RacingCardHeaderViewModel(model: mockModel)

        #expect(vm.imageResource == mockModel.racingCategory.imageResource)
    }

    @Test
    func countdownStringIsFormattedCorrectly() {
        let vm = RacingCardHeaderViewModel(model: mockModel)

        let now = Date()
        let future = mockModel.advertisedStart
        let seconds = max(0, now.distance(to: future))

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated

        let expected = formatter.string(from: seconds) ?? "-"
        let actual = vm.countdownSting

        #expect(expected == actual)
    }

    @Test
    func accessibilityLabelIncludesAllComponents() {
        let vm = RacingCardHeaderViewModel(model: mockModel)
        let label = vm.accessibilityLabel

        let now = Date()
        let future = mockModel.advertisedStart
        let seconds = max(0, now.distance(to: future))

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated

        let expectedCountdown = formatter.string(from: seconds) ?? "-"

        #expect(label.contains(mockModel.racingCategory.accessibilityLabel))
        #expect(label.contains(mockModel.title))
        #expect(label.contains(mockModel.subTitle))
        #expect(label.contains(expectedCountdown))
    }
}
