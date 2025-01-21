//
//  Activity.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 10/27/24.
//
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var student: Student {
        Student.sampleData.first!
    }
    
    var activity: Activity {
        Activity.sampleData.first!
    }
    
    init() {
        let schema = Schema([Student.self, Payment.self, Activity.self, Lesson.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertSampleData()
            try context.save()
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }
    
    private func insertSampleData() {
        for student in Student.sampleData {
            context.insert(student)
        }
        
        for activity in Activity.sampleData {
            context.insert(activity)
        }
        
        let payment = Payment.sampleData.first!
        payment.students = [Student.sampleData[0], Student.sampleData[1]]
        context.insert(payment)
    }
}
