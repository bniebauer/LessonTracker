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
    
    var payment: Payment {
        let payment = Payment.sampleData.first!
        payment.activity = Activity.sampleData.first!
        payment.student = Student.lilly
        return payment
    }
    
    init() {
        let schema = Schema([Payment.self, Activity.self])
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
        
        for activity in Activity.sampleData {
            context.insert(activity)
        }
        
        for payment in Payment.sampleData {
            payment.date = .now
            payment.activity = Activity.sampleData.first!
            payment.student = Student.lilly
            context.insert(payment)
        }
    }
}
