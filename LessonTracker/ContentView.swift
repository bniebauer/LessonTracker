//
//  ContentView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationSplitView {
            TabView {
                LogView()
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                
                HistoryListView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("History")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .navigationTitle("Lesson Tracker")
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
