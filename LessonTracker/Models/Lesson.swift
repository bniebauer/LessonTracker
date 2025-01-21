//
//  Item.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import Foundation
import SwiftData
import CloudKit


@Model
class Lesson {
    var student: Student
    var activity: Activity
    var timestamp: Date
    
    var payment: Payment?
    
    init(student: Student, activity: Activity, timestamp: Date) {
        self.timestamp = timestamp
        self.activity = activity
        self.student = student
    }
}

extension Lesson {
    static var sampleData: [Lesson] = [
        Lesson(student: Student.sampleData[0], activity: Activity.sampleData[0], timestamp: .now),
        Lesson(student: Student.sampleData[1], activity: Activity.sampleData[0], timestamp: .now),
    ]
}

