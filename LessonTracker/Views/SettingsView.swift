//
//  SettingsView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Query(sort: \Student.age) private var students: [Student]
    @Query private var activities: [Activity]
    
    @Environment(\.modelContext) private var context
    
    @State var newStudent: Student?
    @State var newActivity: Activity?
    
    var body: some View {
        Form {
            Section("Students") {
                ForEach(students, id: \.self) { student in
                    Text(student.name)
                }
                Button("Add Student") {
                    addNewStudent()
                }
            }
            Section("Activities") {
                ForEach(activities) { activity in
                    Text(activity.name)
                }
                Button("Add Activity") {
                    addNewActivity()
                }
            }
        }
        .navigationTitle("Settings")
        .sheet(item: $newStudent) { student in
            NavigationStack {
                StudentDetail(student: student)
            }
            .interactiveDismissDisabled()
        }
        .sheet(item: $newActivity) { activity in
            NavigationStack {
                ActivityDetail(activity: activity)
            }
            .interactiveDismissDisabled()
        }
    }
    
    private func addNewStudent() {
        let newStudent = Student(name: "", age: 0)
        context.insert(newStudent)
        self.newStudent = newStudent
    }
    
    private func addNewActivity() {
        let newActivity = Activity(name: "")
        context.insert(newActivity)
        self.newActivity = newActivity
        
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}
