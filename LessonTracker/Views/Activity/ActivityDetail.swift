//
//  ActivityDetail.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/11/24.
//

import SwiftUI

struct ActivityDetail: View {
    @Bindable var activity: Activity
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Form {
            TextField("New Activity Title", text: $activity.name)
        }
        .navigationTitle("New Activity")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    context.delete(activity)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ActivityDetail(activity: SampleData.shared.activity)
    }
}
