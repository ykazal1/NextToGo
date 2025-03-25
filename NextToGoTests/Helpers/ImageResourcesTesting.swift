//
//  ImageResourcesTesting.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation
import DeveloperToolsSupport
import Testing
@testable import NextToGo

@Suite
struct ImageResourcesTesting {
    
    @Test
    func anzImageResource() {
        for country in ["aus", "nz"] {
            for number in 1...10 {
                let resource = ImageResource.getImageResourceForGreyhoundSilks(country: country, number: number)
                #expect(resource == ImageResource(name: "anz-\(number)", bundle: Bundle.init(for: MainAppClass.self)))
            }
        }
    }
    @Test
    func usImageResource() {
        for number in 1...9 {
            let resource = ImageResource.getImageResourceForGreyhoundSilks(country: "us", number: number)
            #expect(resource == ImageResource(name: "us-\(number)", bundle: Bundle.init(for: MainAppClass.self)))
        }
    }
    @Test
    func ukIREImageResource() {
        for country in ["uk", "ire"] {
            for number in 1...8 {
                let resource = ImageResource.getImageResourceForGreyhoundSilks(country: country, number: number)
                #expect(resource == ImageResource(name: "uk-\(number)", bundle: Bundle.init(for: MainAppClass.self)))
            }
        }
    }

    @Test
    func fallbackToDefaultImage() {
        let testCases = [
            ("aus", 11),
            ("us", 10),
            ("uk", 9),
            ("ire", 9),
            ("unknown", 5),
            ("", 1)
        ]

        for (country, number) in testCases {
            let resource = ImageResource.getImageResourceForGreyhoundSilks(country: country, number: number)
            #expect(resource == ImageResource(name: "all-country-default", bundle: Bundle.init(for: MainAppClass.self)))
        }
    }
}


