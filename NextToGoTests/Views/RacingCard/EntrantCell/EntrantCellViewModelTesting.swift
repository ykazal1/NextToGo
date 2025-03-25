//
//  EntrantCellViewModelTesting.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation
import Testing
@testable import NextToGo

@Suite
struct EntrantCellViewModelTesting {
    
    private let model = EntrantCellModel(
        id: "123",
        number: 7,
        silkURL: "https://fakeurl.com/silk.png",
        last20Stars: "aaxaa",
        title: "Runner R7",
        jockey: "John Smith",
        trainer: "Jane Doe",
        racingCategory: .horse,
        winPrice: 2.5,
        country: "AUS",
        accessibilityLabel: "Runner 7 trained by Jane Doe, ridden by John Smith"
    )

    @Test
    func displayValues() {
        let vm = EntrantCellViewModel(model: model)

        #expect(vm.displayTitle == "Runner R7")
        #expect(vm.displayTrainer == "Jane Doe")
        #expect(vm.displayJockey == "John Smith")
        #expect(vm.showJockey == true)
        #expect(vm.winPrice == 2.5)
    }

    @Test
    func silkURLIsValid() {
        let vm = EntrantCellViewModel(model: model)
        #expect(vm.displaySilkImageURL?.absoluteString == "https://fakeurl.com/silk.png")
    }

    @Test
    func silkURLIsUnvalid() {
        let model = EntrantCellModel(
            id: "123",
            number: 7,
            silkURL: "",
            last20Stars: "aaxaa",
            title: "Runner R7",
            jockey: "John Smith",
            trainer: "Jane Doe",
            racingCategory: .horse,
            winPrice: 2.5,
            country: "AUS",
            accessibilityLabel: "Runner 7 trained by Jane Doe, ridden by John Smith"
        )
        let vm = EntrantCellViewModel(model: model)
        #expect(vm.displaySilkImageURL == nil)
    }

    @Test
    func last20StartsIsPresentForHorse() {
        let vm = EntrantCellViewModel(model: model)
        #expect(vm.displayLast20Starts == "aaxaa")
    }

    @Test
    func last20StartsIsHiddenForGreyhound() {
        var greyhoundModel = EntrantCellModel(
            id: "123",
            number: 7,
            silkURL: "https://fakeurl.com/silk.png",
            last20Stars: "aaxaa",
            title: "Runner R7",
            jockey: nil,
            trainer: "Jane Doe",
            racingCategory: .greyhound,
            winPrice: 2.5,
            country: "AUS",
            accessibilityLabel: "Runner 7 trained by Jane Doe, ridden by John Smith"
        )
        let vm = EntrantCellViewModel(model: greyhoundModel)
        #expect(vm.displayJockey == "-")
        #expect(vm.showJockey == false)
        #expect(vm.isGreyhound == true)
        #expect(vm.displayLast20Starts == nil)
    }

    @Test
    func imageResourceForGreyhound() {
        var greyhoundModel = EntrantCellModel(
            id: "123",
            number: 7,
            silkURL: "https://fakeurl.com/silk.png",
            last20Stars: "aaxaa",
            title: "Runner R7",
            jockey: "John Smith",
            trainer: "Jane Doe",
            racingCategory: .greyhound,
            winPrice: 2.5,
            country: "AUS",
            accessibilityLabel: "Runner 7 trained by Jane Doe, ridden by John Smith"
        )
        let vm = EntrantCellViewModel(model: greyhoundModel)
        #expect(vm.imageResourceForGreyhound == .getImageResourceForGreyhoundSilks(country: "AUS", number: 7))
    }

    @Test
    func accessibilityLabelMatchesModel() {
        let vm = EntrantCellViewModel(model: model)
        #expect(vm.accessibilityLabel == "Runner 7 trained by Jane Doe, ridden by John Smith")
    }
}
