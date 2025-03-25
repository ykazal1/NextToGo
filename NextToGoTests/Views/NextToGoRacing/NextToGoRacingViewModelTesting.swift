//
//  NextToGoRacingViewModelTesting.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation
import Testing
@testable import NextToGo

@Suite
struct NextToGoRacingViewModelTesting {

    private let sampleRaces: [RaceModel] = [
        RaceModel(
            id: "1",
            advertisedStart: Date().addingTimeInterval(300),
            racingCategory: .horse,
            title: "Race 1",
            subTitle: "1200m"
        ),
        RaceModel(
            id: "2",
            advertisedStart: Date().addingTimeInterval(-30),
            racingCategory: .greyhound,
            title: "Race 2",
            subTitle: "520m"
        ),
        RaceModel(
            id: "3",
            advertisedStart: Date().addingTimeInterval(-70),
            racingCategory: .harness,
            title: "Race 3",
            subTitle: "1600m"
        ),
    ]

    @MainActor @Test
    func filterAndPublishRacesWithAllCategoriesSelected() async {
        let spyAPIClient = SpyAPIClient(nextRacesResult: sampleRaces)
        let viewModel = NextToGoRacingViewModel(apiCleint: spyAPIClient)
        viewModel.isHorseRacingSelected = true
        viewModel.isGreyhoundSelected = true
        viewModel.isHarnessSelected = true
        await viewModel.fetchData()

        let ids = viewModel.nextRacesPublished.map(\.id)
        #expect(ids.contains("1"))
        #expect(ids.contains("2"))
        #expect(!ids.contains("3")) // filtered due to time
        #expect(viewModel.nextRacesPublished.count == 2)
    }

    @MainActor @Test
    func filterAndPublishRacesWithOnlyHorseSelected() async {
        let spyAPIClient = SpyAPIClient(nextRacesResult: sampleRaces)
        let viewModel = NextToGoRacingViewModel(apiCleint: spyAPIClient)
        viewModel.isHorseRacingSelected = true
        viewModel.isGreyhoundSelected = false
        viewModel.isHarnessSelected = false
        await viewModel.fetchData()

        let ids = viewModel.nextRacesPublished.map(\.id)
        #expect(ids.contains("1"))
        #expect(!ids.contains("2"))
        #expect(!ids.contains("3"))
        #expect(viewModel.nextRacesPublished.count == 1)
    }

    @MainActor @Test
    func selectedCategoriesReflectCorrectly() {
        let viewModel = NextToGoRacingViewModel()
        viewModel.isHorseRacingSelected = true
        viewModel.isGreyhoundSelected = false
        viewModel.isHarnessSelected = true

        let selected = viewModel.selectedCategory
        #expect(selected.contains(.horse))
        #expect(selected.contains(.harness))
        #expect(!selected.contains(.greyhound))
    }

    @MainActor @Test
    func pollingTaskManagerStartPolling() async {
        let spyTaskManager = SpyPollingTaskManager()
        let viewModel = NextToGoRacingViewModel(pollingTaskManager: spyTaskManager)
        await viewModel.startPolling()

        await #expect(spyTaskManager.isActive() == true)
        await #expect(spyTaskManager.setCallCount == 1)
    }

    @MainActor @Test
    func pollingTaskManagerStopPolling() async {
        let spyTaskManager = SpyPollingTaskManager()
        let viewModel = NextToGoRacingViewModel(pollingTaskManager: spyTaskManager)
        await viewModel.startPolling()
        await #expect(spyTaskManager.cancelCallCount == 1)
        await viewModel.stopPolling()

        await #expect(spyTaskManager.isActive() == false)
        await #expect(spyTaskManager.cancelCallCount == 2)
    }
}
