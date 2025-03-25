//
//  SystemIcons.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import SwiftUICore

enum SystemIcon: String {
    case checked = "checkmark.square.fill"
    case unchecked = "square"
    case arrowUp = "chevron.compact.up"
    case arrowDown = "chevron.compact.down"
}
extension Image {
    /// Initializes an `Image` instance using a `SystemIcon`.
    /// - Parameter systemIcon: A predefined enum value representing a valid SF Symbol name.
    /// This provides a type-safe way to use system icons.
    init(systemIcon: SystemIcon) {
        self.init(systemName: systemIcon.rawValue)
    }
}
