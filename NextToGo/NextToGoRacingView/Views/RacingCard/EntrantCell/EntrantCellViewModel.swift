//
//  EntrantCellViewModel.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation
import DeveloperToolsSupport

final class EntrantCellViewModel: ObservableObject {
    @Published var winPrice: Double
    private let model: EntrantCellModel

    init(model: EntrantCellModel) {
        self.model = model
        self.winPrice = model.winPrice
    }

    var displayTitle: String {
        model.title
    }

    var displayTrainer: String {
        model.trainer
    }

    var displayJockey: String {
        model.jockey ?? "-"
    }

    var showJockey: Bool {
        model.jockey != nil
    }

    var displaySilkImageURL: URL? {
        guard let urlString = model.silkURL else { return nil }
        return URL(string: urlString)
    }

    var isGreyhound: Bool {
        model.racingCategory == .greyhound
    }

    var displayLast20Starts: String? {
        guard !isGreyhound else { return nil }
        return model.last20Stars
    }

    var imageResourceForGreyhound: ImageResource {
        .getImageResourceForGreyhoundSilks(country: model.country, number: model.number)
    }

    var accessibilityLabel: String {
        model.accessibilityLabel
    }
}
