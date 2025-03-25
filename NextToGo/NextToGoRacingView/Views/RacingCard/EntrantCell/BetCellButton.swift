//
//  BetCellButton.swift
//  NextToGo
//
//  Created by yacob kazal on 23/3/2025.
//

import SwiftUI

struct BetCellButton: View {
    private enum PriceChangedDirection {
        case up, down
    }
    let price: Double
    let title: String
    @Binding var isPressed: Bool

    private let buttonWidth: CGFloat = 40
    @State private var counter = 0
    @State private var borderColor: Color = .gray
    @State private var borderWidth: CGFloat = 0.5
    @State private var chevronUpOpacity: CGFloat = 0
    @State private var chevronDownOpacity: CGFloat = 0

    // UI hierarchy
    // body
    //  |- VStack (spacing: 0)
    //      |- chevronUp
    //      |   |- Image(systemName: "chevron.compact.up")
    //      |- buttonView
    //      |   |- Button
    //      |   |   |- VStack
    //      |   |   |   |- priceView
    //      |   |   |   |   |- Text (formatted price or "SP")
    //      |   |   |   |- titleView
    //      |   |   |   |   |- Text (title)
    //      |- chevronDown
    //          |- Image(systemName: "chevron.compact.down")

    var body: some View {
        VStack(spacing: 0){
            chevronUp
            buttonView
            chevronDown
        }
        .onChange(of: price, animatePriceChange)
        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
    }

    private var chevronUp: some View {
        Image(systemIcon: .arrowUp)
            .renderingMode(.template)
            .frame(height: 8)
            .foregroundColor(.green)
            .opacity(chevronUpOpacity)
    }

    private var chevronDown: some View {
        Image(systemIcon: .arrowDown)
            .renderingMode(.template)
            .frame(height: 8)
            .foregroundColor(.red)
            .opacity(chevronDownOpacity)
    }

    private var titleView: some View {
        Text(title)
            .font(.caption2)
            .foregroundStyle(isPressed ? .white : .gray)
    }

    private var priceView: some View {
        Text(price == 0 ? "SP" : String(format: "%.1f", price))
            .font(.caption)
            .bold()
            .animation(.default)
            .foregroundStyle(isPressed ? .white : .primary)
    }

    private var buttonView: some View {
        Button {
            handleTap()
        } label: {
            VStack {
                priceView
                titleView
            }
            .frame(width: 40)
        }
        .padding(.horizontal, 8)
        .background(isPressed ? Color.orange : Color.gray.opacity(0.1))
        .clipShape(
            RoundedRectangle(cornerRadius: 6)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(borderColor, lineWidth: borderWidth)
        )
    }

    private func handleTap() {
        counter += 1
        isPressed.toggle()
        // TODO: - Add to the BetSlip
    }

    private func animatePriceChange(oldValue: Double, newValue: Double) {
        Logger.log("change price from:\(oldValue) to \(newValue)", level: .info)
        guard oldValue != newValue else { return }

        let direction: PriceChangedDirection = newValue > oldValue ? .up : .down
        let animation = Animation.easeInOut(duration: 3).repeatCount(1, autoreverses: true)

        withAnimation(animation) {
            applyPriceChangeStyle(for: direction)
        } completion: {
            withAnimation(animation) {
                resetPriceChangeStyle()
            }
        }
    }

    private func applyPriceChangeStyle(for direction: PriceChangedDirection) {
        switch direction {
        case .up:
            chevronUpOpacity = 1
            chevronDownOpacity = 0
            borderColor = .green
        case .down:
            chevronUpOpacity = 0
            chevronDownOpacity = 1
            borderColor = .red
        }
        borderWidth = 1
    }

    private func resetPriceChangeStyle() {
        chevronUpOpacity = 0
        chevronDownOpacity = 0
        borderColor = .gray
        borderWidth = 0.5
    }
}
