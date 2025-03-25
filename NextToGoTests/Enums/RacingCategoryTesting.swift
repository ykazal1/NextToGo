//
//  RacingCategoryTesting.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//



import Foundation
import Testing
@testable import NextToGo
@Suite
struct RacingCategoryTesting {
    @Test
    func rawValueMapping() {
        #expect(RacingCategory.greyhound.rawValue == "9daef0d7-bf3c-4f50-921d-8e818c60fe61")
        #expect(RacingCategory.harness.rawValue == "161d9be2-e909-4326-8c2c-35ed71fb460b")
        #expect(RacingCategory.horse.rawValue == "4a2788f8-e825-4d36-9894-efd4baf1cfae")
    }
    @Test
    func imageResourceMapping() {
        #expect(RacingCategory.greyhound.imageResource == .greyhound)
        #expect(RacingCategory.harness.imageResource == .harness)
        #expect(RacingCategory.horse.imageResource == .horseRacing)
        #expect(RacingCategory.unknown.imageResource == .warning)
    }
    @Test
    func accessibilityLabels() {
        #expect(RacingCategory.greyhound.accessibilityLabel == "Greyhound")
        #expect(RacingCategory.harness.accessibilityLabel == "Harness Racing")
        #expect(RacingCategory.horse.accessibilityLabel == "Horse Racing")
        #expect(RacingCategory.unknown.accessibilityLabel == "unknown")
    }
    
    @Test
    func allCasesExcludesUnknown() {
        let allCases = RacingCategory.allCases
        #expect(allCases.contains(.horse))
        #expect(allCases.contains(.greyhound))
        #expect(allCases.contains(.harness))
        #expect(!allCases.contains(.unknown))
        #expect(allCases.count == 3)
    }
}
