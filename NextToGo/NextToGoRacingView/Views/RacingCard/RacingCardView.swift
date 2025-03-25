//
//  RacingCardView.swift
//  NextToGo
//
//  Created by yacob kazal on 23/3/2025.
//

import SwiftUI

struct RacingCardView: View {
    @StateObject
    var viewModel: RacingCardViewModel

    // UI hierarchy
    // body
    //  |- List
    //  |   |- Section
    //  |   |   |- header
    //  |   |   |   |- RacingCardHeaderView
    //  |   |   |- ForEach (viewModel.raceCards)
    //  |   |   |   |- EntrantCellView
    var body: some View {
        List {
            Section {
                ForEach(viewModel.raceCards) { raceCard in
                    EntrantCellView(
                        viewModel: EntrantCellViewModel(
                            model: raceCard
                        )
                    )
                        .listRowSeparatorTint(.gray)
                }
            } header: {
                RacingCardHeaderView(viewModel: RacingCardHeaderViewModel(model: viewModel.headerModel))
            }
            .listSectionSeparator(.hidden, edges: .top)
        }
        .listStyle(.plain)
        .onAppear {
            Logger.log("onAppear: \(viewModel.headerModel.title)", level: .info)
            viewModel.onAppear()
        }
        .onDisappear {
            Logger.log("onDisappear: \(viewModel.headerModel.title)", level: .info)
            viewModel.onDisappear()
        }
    }
}
