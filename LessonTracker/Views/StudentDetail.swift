//
//  StudentDetail.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/11/24.
//

import SwiftUI

struct StudentDetail: View {
    @Bindable var student: Student
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Form {
            TextField("Name", text: $student.name)
            Stepper("Age: \(student.age)", value: $student.age)
        }
        .navigationTitle("New Student")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    do {
                        try context.save()
                    } catch {
                        print("Error saving: \(error)")
                    }
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    context.delete(student)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        StudentDetail(student: SampleData.shared.student)
    }
}
