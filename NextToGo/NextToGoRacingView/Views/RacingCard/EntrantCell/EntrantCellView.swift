//
//  EntrantCellView.swift
//  NextToGo
//
//  Created by yacob kazal on 23/3/2025.
//

import SwiftUI
enum FocusedView: Hashable {
     case A
}
struct EntrantCellView: View {
    @State private var isPressed: Bool = false
    @ObservedObject
    var viewModel: EntrantCellViewModel
    @AccessibilityFocusState private var isEmailFocused: Bool

    // UI hierarchy
    // body
    //  |- HStack
    //      |- titleSection
    //      |   |- VStack
    //      |   |   |- silkImage
    //      |   |   |   |- Image Silk
    //      |   |   |   |- Text (last20Stars)
    //      |- silkSection
    //      |   |- VStack
    //      |   |   |- Text (title)
    //      |   |   |- Text (jockey) if racingCategory != .greyhound
    //      |   |   |- Text (trainer)
    //      |- Spacer
    //      |- BetCellButton

    var body: some View {
        HStack(spacing: 4){
            titleSection
            silkSection
            Spacer()
            BetCellButton(
                price: viewModel.winPrice,
                title: "WIN",
                isPressed: $isPressed
            )
                .buttonStyle(.plain)
        }
        .onChange(of: viewModel.winPrice, { oldValue, newValue in
            guard isEmailFocused else { return }
            if UIAccessibility.isVoiceOverRunning {
                AccessibilityNotification.LayoutChanged().post()
                Task {
                    await waitHalfSecond()
                }
            }
            AccessibilityNotification.Announcement("For \(viewModel.displayTitle), Price has changed from $\(oldValue) to $\(newValue)").post()
        })
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(viewModel.accessibilityLabel), \(betSelectionForAccessibility())")
        .accessibilityAddTraits(.isButton)
        .accessibilityAction {
            
            if UIAccessibility.isVoiceOverRunning {
                AccessibilityNotification.LayoutChanged().post()
                Task {
                    await waitHalfSecond()
                }
            }
            isPressed.toggle()
            AccessibilityNotification.Announcement("For \(viewModel.displayTitle), \(betSelectionForAccessibility())").post()
        }
        .accessibilityFocused($isEmailFocused)
    }
    func betSelectionForAccessibility() -> String {
        isPressed ? "Bet is selected" : "Bet is deselected"
    }
    func waitHalfSecond() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
    }

    private var titleSection: some View {
        VStack(alignment: .center) {
            silkImage
                .frame(width: 32, height: 24)
                .padding(.trailing, 4)
            if let displayLast20Starts = viewModel.displayLast20Starts {
                Text(displayLast20Starts)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .frame(width: 24)
            }
        }
        .alignmentGuide(.listRowSeparatorLeading) {$0[.listRowSeparatorLeading] + 32 }
    }

    private var silkSection: some View {
        VStack(alignment: .leading) {
            Text(viewModel.displayTitle)
                .font(.caption)
                .bold()
            if viewModel.showJockey {
                Text(viewModel.displayJockey)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            Text(viewModel.displayTrainer)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }

    @ViewBuilder
    var silkImage: some View {
        if viewModel.isGreyhound {
            buildGreyhoundSilkImage()
        } else {
            buildJockeySilkImage()
        }
    }

    private func buildJockeySilkImage() -> some View {
        AsyncImage(url: viewModel.displaySilkImageURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .primary, radius: 3)
            case .failure, .empty:
                Image(.blankSilk)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            @unknown default:
                ProgressView()
            }
        }
    }

    private func buildGreyhoundSilkImage() -> some View {
        Image(viewModel.imageResourceForGreyhound)
            .clipShape(
                RoundedRectangle(cornerRadius: 4)
            )
            .shadow(color: .primary ,radius: 3)
        
            .padding(6)
    }
}

