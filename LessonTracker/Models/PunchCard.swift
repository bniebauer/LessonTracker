//
//  PunchCard.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/14/24.
//

import Foundation
import SwiftUI

@Observable
class PunchCard {
    private var activity: Activity
    private var student: Student
    private var lessons: [Lesson]
    
    var title: String
    var totalNumberOfLessons: Int
    var numberOfLessonsCompleted: Int
    
    init(activity: Activity, student: Student, totalNumberOfLessons: Int, lessons: [Lesson]) {
        self.activity = activity
        self.student = student
        self.lessons = lessons
        
        self.title = activity.name
        self.totalNumberOfLessons = totalNumberOfLessons
        self.numberOfLessonsCompleted = lessons.count
    }
    
    var topRow: Int {
        totalNumberOfLessons / 2
    }

    var bottomRow: Int {
        totalNumberOfLessons % 2 == 0 ? totalNumberOfLessons / 2 : (totalNumberOfLessons / 2) + 1
    }
    
    var topRange: Range<Int> {
        Range(uncheckedBounds: (lower: 0, upper: topRow))
    }
    
    var bottomRange: Range<Int> {
        Range(uncheckedBounds: (lower: bottomRow, upper: totalNumberOfLessons))
    }
    
    func incrementNumberOfLessonsCompleted(_ index: Int) -> Lesson? {
        if index <= totalNumberOfLessons - 1 && index >= numberOfLessonsCompleted {
            let lesson = Lesson(student: student, activity: activity, timestamp: .now)
            lessons.append(lesson)
            numberOfLessonsCompleted = lessons.count
            
            return lesson
        }
        return nil
    }
    
    func undo() -> Lesson {
        let lesson = lessons.removeLast()
        numberOfLessonsCompleted = lessons.count
        return lesson
    }
}

