//
//  HistoryListView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct HistoryListView: View {
    @Query private var lessons: [Lesson]
    @Query private var payments: [Payment]
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            if payments.isEmpty {
                ContentUnavailableView {
                    Label("No History", systemImage: "tray.fill")
                } description: {
                    Text("New lesson transactions will be displayed here.")
                }
            } else {
                List {
                    ForEach(payments) { payment in
                        NavigationLink("\(payment.activity.name) - \(payment.date, format: Date.FormatStyle(date: .numeric)) - \(payment.students.count)") {
                            HistoryDetails(payment: payment)
                        }
                    }
                }
            }
        }
        .navigationTitle("History")
    }
}

#Preview {
    NavigationStack {
        HistoryListView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}
