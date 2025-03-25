//
//  RacingCategory.swift
//  NextToGo
//
//  Created by yacob kazal on 24/3/2025.
//

import DeveloperToolsSupport

enum RacingCategory: String, CaseIterable {
    case greyhound = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
    case harness = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    case horse = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    case unknown

    /// Returns the associated `ImageResource` for the racing category.
    /// This is used to display an appropriate icon or image in the UI.
    var imageResource: ImageResource {
        switch self {
        case .greyhound: .greyhound
        case .harness: .harness
        case .horse: .horseRacing
        case .unknown: .warning
        }
    }

    /// Provides a localized, human-readable label for the racing category,
    /// intended for accessibility and screen reader support.
    var accessibilityLabel: String {
        switch self {
        case .greyhound: "Greyhound"
        case .harness: "Harness Racing"
        case .horse: "Horse Racing"
        case .unknown: "unknown"
        }
    }

    /// Returns all valid racing categories except `.unknown`.
    /// Useful for filters, tabs, or toggles where unknown should be excluded.
    static var allCases: [RacingCategory] {
        [.horse, .greyhound, .harness]
    }
}
