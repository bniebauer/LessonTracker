//
//  SettingsView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Query private var students: [Student]
    @Query private var activities: [Activity]
    
    @Environment(\.modelContext) private var context
    
    @State var newStudentName: String = ""
    @State var newActivityName: String = ""
    @State var priceString: String = ""
    @State var price: Double = 0.0
    
    var body: some View {
        Form {
            Section("Students") {
                ForEach(students) { student in
                    Text(student.name)
                        .swipeActions {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                context.delete(student)
                            }
                        }
                }
                
                HStack {
                    TextField("New Student", text: $newStudentName)
                    Button("Add Student", action: addNewStudent)
                }
            }
            
            Section("Activities") {
                ForEach(activities) { activity in
                    Text(activity.name)
                }
            }
            
            Section("Add new activity") {
                TextField("New Activity", text: $newActivityName)
                Stepper("Price: \(price, format: .currency(code: "USD"))", value: $price, in: 0...200, step: 20)
                Button("Add Activity", action: addNewActivity)
            }
            
        }
        .navigationTitle("Settings")
    }
    
    private func addNewStudent() {
        if newStudentName.isEmpty { return }
        
        let newStudent = Student(name: newStudentName, age: 0)
        context.insert(newStudent)
        newStudentName = ""
    }
    
    private func addNewActivity() {
        if newActivityName.isEmpty { return }
        
        let newActivity = Activity(name: newActivityName, price: price)
        context.insert(newActivity)
        newActivityName = ""
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}
