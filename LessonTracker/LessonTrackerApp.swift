//
//  LessonTrackerApp.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

@main
struct LessonTrackerApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Lesson.self,
            Payment.self,
            Activity.self,
            Student.self,
        ], inMemory: false, isAutosaveEnabled: true)
    }
}
