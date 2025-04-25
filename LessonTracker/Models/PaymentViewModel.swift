//
//  PaymentViewModel.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 4/15/25.
//

import Foundation

class PaymentViewModel: ObservableObject {
    @Published var selectedStudent: Student?
    @Published var selectedActivitiy: Activity?
    @Published var numberOfLessons: Int = 0
    @Published var amount: Double = 0
    @Published var selectedPaymentType: PaymentType = PaymentType.Cash
    @Published var selectedDate: Date = Date()
    @Published var confirmationNumber: String = ""
    
    var studentLabel: String {
        get {
            selectedStudent?.name ?? "Select Student"
        }
    }
    var activityLabel: String {
        get {
            selectedActivitiy?.name ?? "Select Activity"
        }
    }
    
    func purchaseLesson() -> Payment? {
        guard let student = selectedStudent, let activity = selectedActivitiy else {
            return nil
        }
        
        let purchasedLesson = Payment(student: student, activity: activity, price: amount, numberOfLessons: numberOfLessons)
        print("\(purchasedLesson.numberOfLessons)")
        purchasedLesson.date = selectedDate
        purchasedLesson.confirmation = confirmationNumber
        
        return purchasedLesson
    }
    
    func resetFields() {
        selectedStudent = nil
        selectedActivitiy = nil
        numberOfLessons = 0
        amount = 0
        selectedPaymentType = PaymentType.Cash
        selectedDate = Date()
        confirmationNumber = ""
    }
}
