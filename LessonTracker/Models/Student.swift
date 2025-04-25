//
//  Student.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/11/24.
//

import Foundation
import SwiftData

@Model
class Student: Identifiable, Equatable {
    var id = UUID()
    var name: String = ""
    var age: Int = 1
    
    @Relationship(inverse: \Payment.student)
    var payments: [Payment]?
    
    init(name: String, age: Int = 1) {
        self.name = name
        self.age = age
        self.payments = []
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

extension Student {
    static let sampleData = [
        Student(name: "Breanna", age: 16),
        Student(name: "Kaleb", age: 11),
        Student(name: "Lilly", age: 9),
    ]
    
    static let breanna = sampleData[0]
    static let kaleb = sampleData[1]
    static let lilly = sampleData[2]
}
