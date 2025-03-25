//
//  APIClient.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

protocol APIClinetProtocol: Actor {
    func fetchRace(id: String) async throws -> [EntrantCellModel]
    func fetchNextRaces() async throws -> [RaceModel]
}

actor APIClient: APIClinetProtocol {
    /// Fetches detailed race card data for a given race ID from the Neds Racing API.
    /// - Parameter id: The unique identifier of the race.
    /// - Returns: An array of `EntrantCellModel` representing the entrants in the race.
    /// - Throws: An error if the network request or decoding fails.
    func fetchRace(id: String) async throws -> [EntrantCellModel] {
        let url = "https://api.neds.com.au/rest/v1/racing/?method=racecard&id=\(id)"
        let data = try await Networking.request(urlString: url, type: RaceCardResponse.self).data
        return RaceCardDataTransformer.transform(data)
    }

    /// Fetches a list of upcoming races from the Neds Racing API.
    /// - Returns: An array of `RaceModel` representing the upcoming races.
    /// - Throws: An error if the network request or decoding fails.
    func fetchNextRaces() async throws -> [RaceModel] {
        let url = "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=50"
        return try await Networking.request(urlString: url, type: NextRacesResponse.self).data.raceSummaries.values
            .map(RaceSummaryTransformer.transform(_:))
    }
}
