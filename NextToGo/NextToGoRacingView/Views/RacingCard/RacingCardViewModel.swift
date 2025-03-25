//
//  RacingCardViewModel.swift
//  NextToGo
//
//  Created by yacob kazal on 23/3/2025.
//

import Foundation

@MainActor
class RacingCardViewModel: ObservableObject {
    var race: RaceModel
    @Published
    var raceCards = [EntrantCellModel]()
    let apiCleint: APIClinetProtocol
    var hasError: Bool = false

    private let pollingTaskManager: PollingTaskManaging

    init(
        race: RaceModel,
        apiCleint: APIClinetProtocol = APIClient(),
        pollingTaskManager: PollingTaskManaging = PollingTaskManager()
    ) {
        self.race = race
        self.apiCleint = apiCleint
        self.pollingTaskManager = pollingTaskManager
    }

    /// Starts the polling process when the view appears.
    /// Begins an async task that fetches race data periodically.
    func onAppear() {
        Task {
            await startPolling()
        }
    }

    /// Stops the polling process when the view disappears.
    /// Cancels any running polling task to avoid unnecessary background work.
    func onDisappear() {
        Task {
            await stopPolling()
        }
    }

    /// Initiates a new polling loop for fetching race entrant data every 30 seconds.
    /// Cancels any existing polling task before starting a new one.
    func startPolling() async {
        Logger.log("✅ \(race.id)", level: .info)
        // Cancel any existing polling task
        await pollingTaskManager.cancel()
        await pollingTaskManager.set(Task(priority: .utility) { [weak self] in
            guard let self else { return }

            while !Task.isCancelled {
                await self.fetchData()
                try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            }
        })
    }

    /// Cancels the active polling task and logs that polling has stopped.
    func stopPolling() async {
        await pollingTaskManager.cancel()
        Logger.log("⛔️ \(race.id)", level: .info)
    }

    /// Constructs a `RacingCardHeaderModel` from the associated `RaceModel`.
    /// Used to populate the race header view.
    var headerModel: RacingCardHeaderModel {
        RacingCardHeaderModel(
            racingCategory: race.racingCategory,
            title: race.title,
            subTitle: race.subTitle,
            advertisedStart: race.advertisedStart
        )
    }

    /// Asynchronously fetches the latest entrant data for the current race.
    /// Updates the `raceCards` with sorted entrants or sets `hasError` if the fetch fails.
    private func fetchData() async {
        Logger.log("🔁 \(race.id)", level: .info)
        do {
            let entrants = try await fetchRaceEntrants(id: self.race.id)
            raceCards = entrants
                .sorted { $0.number < $1.number }
            hasError = false
        } catch {
            hasError = true
        }
        
    }

    private func fetchRaceEntrants(id: String) async throws -> [EntrantCellModel] {
        try await apiCleint.fetchRace(id: id)
    }
}
