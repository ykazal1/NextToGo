//
//  NextToGoRacingCardHeaderView.swift
//  NextToGo
//
//  Created by yacob kazal on 23/3/2025.
//

import SwiftUI

struct RacingCardHeaderView: View {
    @StateObject var viewModel: RacingCardHeaderViewModel
    
    // UI hierarchy
    // body
    //  |- VStack (spacing: 0)
    //      |- HStack (spacing: 8)
    //      |   |- racerImage
    //      |   |   |- Image (resizable, 32pt width, template rendering)
    //      |   |- title
    //      |   |   |- Text (model.title, .caption font)
    //      |   |- subtitle
    //      |   |   |- Text (model.subTitle, .caption font, gray color)
    //      |   |- Spacer()
    //      |   |- countdown
    //      |       |- TimelineView (refresh every second)
    //      |           |- Text (countdownString, red color, .caption font)
    //      |- Divider (height: 0.25, primary color overlay)

    var body: some View {
        VStack(spacing: 0) {
            headerContent
            Divider()
                .frame(height: 0.25)
                .overlay(.primary)
        }
        .background(.gray.opacity(0.2))
        .clipShape(
            .rect(
                topLeadingRadius: 8,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 8
            )
        ).onAppear {
            AccessibilityNotification.LayoutChanged(self).post()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(viewModel.accessibilityLabel)
    }

    private var headerContent: some View {
        HStack(alignment: .center, spacing: 8) {
            racerImage
            title
            subtitle
            Spacer()
            countdown
        }
        .padding(8)
    }

    private var racerImage: some View {
        Image(viewModel.imageResource)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.primary)
            .frame(width: 32)
    }

    private var title: some View {
        Text(viewModel.title)
            .font(.caption)
            .foregroundColor(.primary)
    }

    private var subtitle: some View {
        Text(viewModel.subtitle)
            .font(.caption)
            .foregroundColor(.gray)
    }

    private var countdown: some View {
        TimelineView(.periodic(from: .now, by: 1)) { timeline in
            Text(viewModel.countdownSting)
                .font(.caption)
                .foregroundColor(.red)
        }
    }
}
