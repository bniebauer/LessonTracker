//
//  ContentView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {    
    var body: some View {
        TabView {
            LogView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Log")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
