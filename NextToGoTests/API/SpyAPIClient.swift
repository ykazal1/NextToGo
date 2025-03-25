//
//  SpyAPIClient.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

@testable import NextToGo

final actor SpyAPIClient: APIClinetProtocol {
    private(set) var fetchRaceCalled = false
    private(set) var fetchRaceCalledWithID: String?
    private(set) var fetchNextRacesCalled = false

    var raceResult: [EntrantCellModel]
    var nextRacesResult: [RaceModel]

    init(raceResult: [EntrantCellModel] = [], nextRacesResult: [RaceModel] = []) {
        self.raceResult = raceResult
        self.nextRacesResult = nextRacesResult
    }

    func fetchRace(id: String) async throws -> [EntrantCellModel] {
        fetchRaceCalled = true
        fetchRaceCalledWithID = id
        return raceResult
    }

    func fetchNextRaces() async throws -> [RaceModel] {
        fetchNextRacesCalled = true
        return nextRacesResult
    }
}
