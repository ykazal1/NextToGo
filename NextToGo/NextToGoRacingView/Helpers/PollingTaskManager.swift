//
//  PollingTaskManager.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

import Foundation

protocol PollingTaskManaging: Actor {
    func set(_ newTask: Task<Void, Never>?)
    func cancel()
    func isActive() -> Bool
}

actor PollingTaskManager: PollingTaskManaging {
    private var task: Task<Void, Never>?

    /// Replaces the current polling task with a new one, cancelling the previous task if it exists.
    /// - Parameter newTask: The new `Task` to set for polling. Can be `nil` to clear the task.
    func set(_ newTask: Task<Void, Never>?) {
        task?.cancel() // cancel old one if any
        task = newTask
    }

    /// Cancels and clears the current polling task if one is active.
    func cancel() {
        task?.cancel()
        task = nil
    }

    /// Checks whether a polling task is currently active.
    /// - Returns: `true` if a task is set, otherwise `false`.
    func isActive() -> Bool {
        task != nil
    }
}
