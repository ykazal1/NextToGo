//
//  PollingTaskManagerTesting.swift
//  NextToGo
//
//  Created by yacob kazal on 25/3/2025.
//


import Foundation
import Testing
@testable import NextToGo

@Suite
struct PollingTaskManagerTesting {

    @Test
    func taskSetAndCancel() async {
        let manager = PollingTaskManager()

        var wasCancelled = false
        let task = Task {
            defer { wasCancelled = Task.isCancelled }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
        }

        await manager.set(task)
        await manager.cancel()

        try? await Task.sleep(nanoseconds: 100_000_000)
        #expect(wasCancelled)
        #expect(task.isCancelled)
        #expect(await manager.isActive() == false)
    }

    @Test
    func overwriteCancelsOldTask() async {
        let manager = PollingTaskManager()

        var cancelled1 = false
        let task1 = Task {
            defer { cancelled1 = Task.isCancelled }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
        }

        let task2 = Task {}

        await manager.set(task1)
        await manager.set(task2)

        try? await Task.sleep(nanoseconds: 100_000_000)
        #expect(cancelled1)
        #expect(task1.isCancelled)
        #expect(!task2.isCancelled)
    }

    @Test
    func isActiveReflectsState() async {
        let manager = PollingTaskManager()
        #expect(await manager.isActive() == false)

        await manager.set(Task {})
        #expect(await manager.isActive() == true)

        await manager.cancel()
        #expect(await manager.isActive() == false)
    }
}
