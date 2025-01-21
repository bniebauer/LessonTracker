//
//  Student.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/11/24.
//

import Foundation
import SwiftData

@Model
class Student {
    var name: String
    var age: Int
    
    var payments = [Payment]()
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension Student {
    static let sampleData = [
        Student(name: "Breanna", age: 16),
        Student(name: "Kaleb", age: 11),
        Student(name: "Lilly", age: 9),
    ]
}
