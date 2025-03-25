//
//  CheckBoxView.swift
//  NextToGo
//
//  Created by yacob kazal on 24/3/2025.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool
    @State private var counter = 0
    let racingCategory: RacingCategory

    var body: some View {
        HStack {
            Image(systemIcon: isChecked ? .checked : .unchecked)
                .renderingMode(.template)
                .foregroundColor(isChecked ? Color(UIColor.systemBlue) : Color.secondary)
            Image(racingCategory.imageResource)
                .renderingMode(.template)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .onTapGesture {
            self.isChecked.toggle()
        }
        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(makeAccessibilityLabel())
        .accessibilityAddTraits(.isButton)
        .accessibilityAction {
            
            if UIAccessibility.isVoiceOverRunning {
                AccessibilityNotification.LayoutChanged().post()
            }
            Task {
                await waitHalfSecond()
            }
            isChecked.toggle()
            AccessibilityNotification.Announcement(makeAccessibilityLabel()).post()
        }
    }

    func makeAccessibilityLabel() -> String {
        var announcementWord = "is selected"
        if !isChecked {
            announcementWord = "is deselected"
        }
        return "\(racingCategory.accessibilityLabel) \(announcementWord)"
    }
    
    /// Asynchronously waits for half a second (500 milliseconds).
    /// 
    /// This is typically used to introduce a brief delay for accessibility or animation purposes,
    /// such as allowing voiceover announcements to complete before updating UI elements.
    func waitHalfSecond() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
    }
}
