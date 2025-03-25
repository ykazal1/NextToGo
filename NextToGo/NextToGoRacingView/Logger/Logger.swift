//
//  Logger.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation

struct Logger {
    static let isEnabled: Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()

    /// Logs a message to the console with contextual metadata including file, function, and line number.
    ///
    /// This function will only output logs when `isEnabled` is true, which defaults to `true` in DEBUG builds.
    /// It includes a log level, file name, function name, and line number to aid debugging.
    ///
    /// - Parameters:
    ///   - message: A closure returning the value to be logged. This is autoclosured to avoid evaluating the message unless logging is enabled.
    ///   - level: The severity level of the log (default is `.debug`).
    ///   - file: The name of the file where the log was called (auto-filled).
    ///   - function: The function name where the log was called (auto-filled).
    ///   - line: The line number where the log was called (auto-filled).
    static func log(_ message: @autoclosure () -> Any,
                    level: LogLevel = .debug,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        guard isEnabled else { return }

        let fileName = (file as NSString).lastPathComponent
        let prefix = "[\(level.rawValue)] \(fileName):\(line) → \(function)"
        print("\(prefix)\n    \(message())\n")
    }
}
