//
//  Payment.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/11/24.
//

import Foundation
import SwiftData

enum PaymentType: String, CaseIterable, Codable  {
    case Cash = "Cash"
    case Check = "Check"
    case Credit = "Credit"
    case Zelle = "Zelle"
}

enum PaymentError: Error, Equatable {
    case DuplicateLesson(on: Date)
    case LessonCannotBeInTheFuture(on: Date)
    case LessonsOutOfRange(reason: String)
}

@Model
class Payment : Identifiable {
    var id: UUID
    
    var activity: Activity
    var student: Student
    
    var type: PaymentType?
    var date: Date
    
    private(set) var lessons: [Date]
    
    var confirmation: String?
    
    var lessonsCompleted: Int {
        lessons.count
    }
    
    var status: String {
        "\(activity.numberOfLessonsPerPayment - lessons.count) Left"
    }
    
    init(student: Student, activity: Activity) {
        id = UUID()
        lessons = []
        date = .now
        self.student = student
        self.activity = activity
    }
    
    func addLesson(_ date: Date) throws {
        let numberOfLessonsRemaining = activity.numberOfLessonsPerPayment - lessonsCompleted
        
        if numberOfLessonsRemaining == 0 {
            throw PaymentError.LessonsOutOfRange(reason: "No more lessons available")
        }
        
        if lessons.contains(date) {
            throw PaymentError.DuplicateLesson(on: date)
        }
        
        self.lessons.append(date)
    }
    
    func removeLesson() throws {
        if lessons.isEmpty {
            throw PaymentError.LessonsOutOfRange(reason: "Lessons array is empty")
        }
        
        lessons.removeLast()
    }
    
    func removeLessons(at offset: IndexSet) throws {
        if lessons.isEmpty {
            throw PaymentError.LessonsOutOfRange(reason: "Lessons array is empty")
        }
        
        lessons.remove(atOffsets: offset)
    }
}


extension Payment {
    static var sampleData: [Payment] = [
        Payment(student: Student.breanna, activity: Activity(name: "Aerial Silks", price: 190)),
        Payment(student: Student.kaleb, activity: Activity(name: "Aerial Silks", price: 190)),
        Payment(student: Student.lilly, activity: Activity(name: "Aerial Silks", price: 190)),
    ]
}
