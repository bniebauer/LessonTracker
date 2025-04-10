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
            TabView {
                LogView()
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
        .modelContainer(for: [
            Student.self,
            Payment.self,
            Activity.self,
        ], inMemory: false, isAutosaveEnabled: true)
    }
}
