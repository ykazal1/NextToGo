//
//  SpyPollingTaskManager.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//

@testable import NextToGo

final actor SpyPollingTaskManager: PollingTaskManaging {
    private(set) var setCallCount = 0
    private(set) var cancelCallCount = 0
    private(set) var lastTask: Task<Void, Never>?
    private var active = false

    func set(_ newTask: Task<Void, Never>?) {
        setCallCount += 1
        lastTask = newTask
        active = newTask != nil
    }

    func cancel() {
        cancelCallCount += 1
        lastTask?.cancel()
        lastTask = nil
        active = false
    }

    func isActive() -> Bool {
        active
    }
}
