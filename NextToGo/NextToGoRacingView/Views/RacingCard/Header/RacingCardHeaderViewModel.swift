//
//  RacingCardHeaderViewModel.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation
import DeveloperToolsSupport

final class RacingCardHeaderViewModel: ObservableObject {
    
    private let model: RacingCardHeaderModel

    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter
    }()

    init(model: RacingCardHeaderModel) {
        self.model = model
    }

    var imageResource: ImageResource {
        model.racingCategory.imageResource
    }

    var title: String {
        model.title
    }

    var subtitle: String {
        model.subTitle
    }

    var countdownSting: String {
        let distance = Date.now.distance(to: model.advertisedStart)
        return formatter.string(from: distance) ?? "-"
    }

    var accessibilityLabel: String {
        "\(model.racingCategory.accessibilityLabel) \(title), \(subtitle), \(countdownSting)"
    }
}
