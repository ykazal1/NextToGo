//
//  NextToGoRacingViewModel.swift
//  NextToGo
//
//  Created by yacob kazal on 21/3/2025.
//

import Foundation

@MainActor
class NextToGoRacingViewModel: ObservableObject {
    
    let apiCleint: APIClinetProtocol
    @Published
    var isHarnessSelected: Bool = true
    @Published
    var isHorseRacingSelected: Bool = true
    @Published
    var isGreyhoundSelected: Bool = true
    @Published
    var nextRacesPublished = [RaceModel]()
    private var nextRaceRaw = [RaceModel]()
    private let pollingTaskManager: PollingTaskManaging
    
    init(
        apiCleint: APIClinetProtocol = APIClient(),
        pollingTaskManager: PollingTaskManaging = PollingTaskManager()
    ) {
        self.apiCleint = apiCleint
        self.pollingTaskManager = pollingTaskManager
    }

    /// Called when the view appears. Begins polling for next races by starting the polling task.
    func onAppear() {
        Task {
            await startPolling()
        }
    }

    /// Called when the view disappears. Cancels the polling task to stop fetching data.
    func onDisappear() {
        Task {
            await stopPolling()
        }
    }

    /// Manually refetches and filters race data and restarts polling.
    /// Useful when user-selected filters change.
    func refetchData() {
        Task {
            filterAndPublishRaces()
            await startPolling()
        }
    }

    /// Begins the polling task that fetches race data periodically until cancelled.
    /// This function also cancels any existing polling task to avoid duplicates.
    func startPolling() async {
        Logger.log("✅ fetchNextRaces",level: .info)
        await pollingTaskManager.cancel()
        await pollingTaskManager.set(Task(priority: .utility) { [weak self] in
            guard let self else { return }

            while !Task.isCancelled {
                await self.fetchData()
                await self.sleepUntilNextRelevantRace()
            }
        })
    }

    /// Sleeps the task until 60 seconds after the next upcoming race's advertised start time.
    /// This spacing prevents redundant data fetches for races already about to begin.
    private func sleepUntilNextRelevantRace() async {
        let nextStart = nextRacesPublished.map(\.advertisedStart).min() ?? Date()
        let sleepUntil = nextStart.addingTimeInterval(60)
        let delay = max(0, Date.now.distance(to: sleepUntil))
        Logger.log("will call fetchData after \(String(format: "%.1f", delay)) seconds", level: .info)
        try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
    }

    /// Fetches the latest next races from the API and publishes them to the UI.
    /// Filters the results on the main thread and logs any errors that occur.
    func fetchData() async {
        Logger.log("🔁 fetchNextRaces", level: .info)
        do {
            let races = try await fetchNextRaces()
            await MainActor.run {
                self.nextRaceRaw = Array(races)
                self.filterAndPublishRaces()
            }
        } catch {
            Logger.log("Error fetching races: \(error)", level: .error)
        }
    }

    /// Computes the list of selected race categories based on toggle states.
    /// Returns an array of `RacingCategory` representing the user's current selection.
    var selectedCategory: [RacingCategory] {
        var result: [RacingCategory] = []
        if isHarnessSelected {
            result.append(.harness)
        }
        if isGreyhoundSelected {
            result.append(.greyhound)
        }
        if isHorseRacingSelected {
            result.append(.horse)
        }
        return result
    }

    /// Filters the raw race list by selected categories and time window,
    /// then sorts and limits the result to 5 upcoming races and publishes it.
    func filterAndPublishRaces() {
        
        let nextRacetoPublish = nextRaceRaw.filter({ race in
            if !selectedCategory.isEmpty, !selectedCategory.contains(race.racingCategory){
                return false
            }
            return race.advertisedStart > Date.now.addingTimeInterval(-60)
        })
        .sorted(by: {$0.advertisedStart < $1.advertisedStart}) // show only Races that didn't start or started less than 60 seconds ago
        .prefix(5) // show only 5 racing cards
        nextRacesPublished = Array(nextRacetoPublish)
    }

    /// Cancels the polling task and logs that data fetching has been stopped.
    func stopPolling() async {
        await pollingTaskManager.cancel()
        Logger.log("⛔️ fetchNextRaces", level: .info)
    }

    private func fetchNextRaces() async throws -> [RaceModel] {
        try await apiCleint.fetchNextRaces()
    }
}
