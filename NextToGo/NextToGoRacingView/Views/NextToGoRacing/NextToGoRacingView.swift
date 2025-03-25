//
//  NextToGoRacingView.swift
//  NextToGo
//
//  Created by yacob kazal on 23/3/2025.
//

import SwiftUI

struct NextToGoRacingView: View {
    @StateObject
    var viewModel = NextToGoRacingViewModel()

    // UI hierarchy
    // body
    //  |- NavigationStack
    //      |- TabView
    //      |   |- ForEach (viewModel.nextRacesPublished)
    //      |   |   |- RacingCardView
    //      |- toolbar
    //      |   |- Text ("Select Event Type")
    //      |   |- CheckBoxView (Horse)
    //      |   |- CheckBoxView (Greyhound)
    //      |   |- CheckBoxView (Harness)
    var body: some View {
        NavigationStack {
            TabView {
                ForEach(viewModel.nextRacesPublished) { race in
                    RacingCardView(
                        viewModel: RacingCardViewModel(race: race)
                    )
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .onAppear {
                viewModel.onAppear()
            }
            .onDisappear {
                viewModel.onDisappear()
            }
            .onChange(of: [viewModel.isHorseRacingSelected, viewModel.isGreyhoundSelected, viewModel.isHarnessSelected]) {
                viewModel.refetchData()
            }
            .toolbar {
                toolbarView
            }
        }
    }

    private var toolbarView: some View {
        HStack {
            Text("Select Event Type")
            CheckBoxView(isChecked: $viewModel.isHorseRacingSelected, racingCategory: .horse)
            CheckBoxView(isChecked: $viewModel.isGreyhoundSelected, racingCategory: .greyhound)
            CheckBoxView(isChecked: $viewModel.isHarnessSelected, racingCategory: .harness)
        }
    }
}
