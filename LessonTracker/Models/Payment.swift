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

@Model
class Payment : Identifiable {
    var id: UUID = UUID()
    
    var activity: Activity
    var numberOfLessons: Int
    
    var amount: Double
    var type: PaymentType
    var date: Date
    
    var lessons: [Lesson] = []
    var confirmation: String?
    var students: [Student] = []
    
    init(activity: Activity, numberOfLessons: Int, amount: Double, type: PaymentType, date: Date, confirmation: String? = nil) {
        self.type = type
        self.amount = amount
        self.date = date
        self.activity = activity
        self.confirmation = confirmation
        self.numberOfLessons = numberOfLessons
    }
    
    init(activity: Activity, numberOfLessons: Int, amount: Double, type: PaymentType, date: Date, students: [Student], confirmation: String? = nil) {
        self.type = type
        self.amount = amount
        self.date = date
        self.activity = activity
        self.confirmation = confirmation
        self.numberOfLessons = numberOfLessons
        self.students = students
    }
    
    init(activity: Activity, numberOfLessons: Int, amount: Double, type: PaymentType, date: Date, students: [Student], lessons: [Lesson], confirmation: String? = nil) {
        self.type = type
        self.amount = amount
        self.date = date
        self.activity = activity
        self.confirmation = confirmation
        self.numberOfLessons = numberOfLessons
        self.students = students
        self.lessons = lessons
    }
}

extension Payment {
    static var sampleData: [Payment] = [
        Payment(activity: Activity.sampleData.first!, numberOfLessons: 12, amount: 100, type: .Cash, date: .now),
        Payment(activity: Activity.sampleData.first!, numberOfLessons: 12, amount: 100, type: .Credit, date: .now, students: [Student.sampleData.first!]),
        Payment(activity: Activity.sampleData.first!, numberOfLessons: 12, amount: 100, type: .Credit, date: .now, students: [Student.sampleData.first!], lessons: [Lesson.sampleData.first!]),
    ]
}
