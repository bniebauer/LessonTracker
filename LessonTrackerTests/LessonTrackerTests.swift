//
//  LessonTrackerTests.swift
//  LessonTrackerTests
//
//  Created by Brenton Niebauer on 9/16/24.
//

import Testing
@testable import LessonTracker

struct LessonTrackerModelTests {
    
    @Test("Activity Creation Test")
    func createActivity() async throws {
        let activity = Activity(name: "Test Activity", price: 100)
        
        #expect(activity.name == "Test Activity")
        #expect(activity.price == 100)
        #expect(activity.numberOfLessonsPerPayment == 1)
    }
    
    @Test("Student Creation Test", arguments: [("Test1", 10), ("Test2", 11), ("Test3", 12)])
    func createStudent(name: String, age: Int) async throws {
        let student = Student(name: name, age: age)
        
        #expect(student.name == name)
        #expect(student.age == age)
    }
    
    @Test("Payment Creation Test")
    func createPayment() async throws {
        let testStudent = Student(name: "Test Student", age: 10)
        let testActivity = Activity(name: "Test Activity", price: 100)
        
        let payment = Payment(student: testStudent, activity: testActivity)
        
        #expect(payment.student == testStudent)
        #expect(payment.activity == testActivity)        
    }
    
    @Test("Adjust number of lessons", arguments: [1, 5 , 10])
    func adjustNumberOfLessons(numOfLessonsAttended: Int) async throws {
        let testStudent = Student(name: "Test Student", age: 10)
        let testActivity = Activity(name: "Test Activity", price: 100, numberOfLessonsPerPayment: 10)
        
        let payment = Payment(student: testStudent, activity: testActivity)
        
        for _ in 0..<numOfLessonsAttended {
            do {
                try payment.addLesson(.now)
            } catch {
                
            }
        }
        
        #expect(payment.lessonsCompleted == numOfLessonsAttended)
    }
    
    @Test("Lessons can not be removed when zero")
    func throwErrorRemovingLessons() async throws {
        let testStudent = Student(name: "Test Student", age: 10)
        let testActivity = Activity(name: "Test Activity", price: 100, numberOfLessonsPerPayment: 10)
        
        let payment = Payment(student: testStudent, activity: testActivity)
        
        #expect(throws: PaymentError.LessonsOutOfRange(reason: "Lessons array is empty")) {
            try payment.removeLesson()
        }
    }
}
