//
//  ImageResources.swift
//  NextToGo
//
//  Created by yacob kazal on 24/3/2025.
//

import DeveloperToolsSupport
import Foundation

extension ImageResource {
    /// Returns an `ImageResource` for a greyhound silk based on the country and number.
    /// - Parameters:
    ///   - country: A lowercase string representing the country code (e.g. "aus", "nz", "us", "uk", "ire").
    ///   - number: The entrant number used to match the silk image resource.
    /// - Returns: An `ImageResource` representing the appropriate silk image.
    /// - Note: Falls back to a default image if the country or number is outside supported ranges.
    static func getImageResourceForGreyhoundSilks(country: String, number: Int) -> ImageResource {
        switch (country.lowercased(), number) {
        case ("aus", 1...10),("nz", 1...10):
            ImageResource(name: "anz-\(number)", bundle: Bundle.init(for: MainAppClass.self))
        case ("us", 1...9):
            ImageResource(name: "us-\(number)", bundle: Bundle.init(for: MainAppClass.self))
        case ("uk", 1...8),("ire", 1...8):
            ImageResource(name: "uk-\(number)", bundle: Bundle.init(for: MainAppClass.self))
        default:
            ImageResource(name: "all-country-default", bundle: Bundle.init(for: MainAppClass.self))
        }
    }
}

class MainAppClass {}
