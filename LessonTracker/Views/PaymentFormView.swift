//
//  PaymentFormView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct PaymentFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Activity.name) private var activities: [Activity]
    @Query private var students: [Student]
    
    @State var selectedStudent: Student?
    @State var selectedActivitiy: Activity?
    @State var numberOfLessons: Int = 0
    @State var amount: Double = 0
    @State var selectedPaymentType: PaymentType = PaymentType.Cash
    @State var selectedDate: Date = Date()
    @State var confirmationNumber: String = ""
    
    
    var activityLabel: String {
        get {
            selectedActivitiy?.name ?? "Select Activity"
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Students") {
                    Picker("Student", selection: $selectedStudent) {
                        ForEach(students) { student in
                            Text("\(student.name)").tag(student)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Activity") {
                    
                    Picker(selection: $selectedActivitiy, label: Text("\(activityLabel)")) {
                        Text("None")
                            .tag(nil as Activity?)
                        ForEach(activities, id: \.self) { activitiy in
                            Text("\(activitiy.name)").tag(activitiy)
                        }
                    }
                    
                    Stepper("Number of lessons: \(numberOfLessons)", value: $numberOfLessons, in: 0...10)
                }
                
                Section("Amount") {
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    Picker(selection: $selectedPaymentType, label: Text("\(selectedPaymentType)")) {
                        ForEach(PaymentType.allCases, id: \.self) { paymentType in
                            Text("\(paymentType)").tag(paymentType)
                        }
                    }
                    DatePicker("Payment Date", selection: $selectedDate, displayedComponents: [.date])
                }
                
                Section("Confirmation Number") {
                    TextField("Confirmation Number", text: $confirmationNumber)
                }
            }
            .navigationTitle("Payment Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Save", action: onSaveTapped)
                }
                ToolbarItem {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func onSaveTapped() {
        guard let student = selectedStudent else {
            return
        }
        guard let activity = selectedActivitiy else {
            return
        }
        
        let purchasedLesson = purchaseLesson(for: student, at: activity)
        modelContext.insert(purchasedLesson)
        
        dismiss()
    }
    
    func purchaseLesson(for student: Student, at activity: Activity) -> Payment {
        let purchasedLesson = Payment(student: student, activity: activity)
        purchasedLesson.date = selectedDate
        purchasedLesson.confirmation = confirmationNumber
        purchasedLesson.student = selectedStudent!
        
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


#Preview {
        PaymentFormView()
            .modelContainer(SampleData.shared.modelContainer)
}
