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
    
    @StateObject var paymentViewModel = PaymentViewModel()
    
    @State private var isShowing = false
    @State private var headerMessage: String = ""
    @State private var confirmationMessage: String = ""
    
    private var studentPicker: some View {
        Picker(
            selection: $paymentViewModel.selectedStudent,
            label: Text(paymentViewModel.studentLabel)
        ) {
            Text("None")
                .tag(nil as Student?)
            ForEach(students) { student in
                Text("\(student.name)").tag(student)
            }
        }
    }
    
    private var activityPicker: some View {
        Picker(
            selection: $paymentViewModel.selectedActivitiy,
            label: Text("\(paymentViewModel.activityLabel)")
        ) {
            Text("None")
                .tag(nil as Activity?)
            ForEach(activities) { activity in
                Text("\(activity.name)")
                    .tag(activity)
            }
        }
    }
    
    private var paymentData: some View {
        Section("Amount") {
            TextField("Amount", value: $paymentViewModel.amount, format: .currency(code: "USD"))
            
            Picker(selection: $paymentViewModel.selectedPaymentType, label: Text("\(paymentViewModel.selectedPaymentType)")) {
                ForEach(PaymentType.allCases, id: \.self) { paymentType in
                    Text("\(paymentType)").tag(paymentType)
                }
            }
            DatePicker("Payment Date", selection: $paymentViewModel.selectedDate, displayedComponents: [.date])
        }
    }
    
    var body: some View {
            Form {
                Section("Students") {
                    studentPicker
                }
                
                Section("Activity") {
                    activityPicker
                }
                
                Section("Number of Lessons") {
                    Stepper(
                        value: $paymentViewModel.numberOfLessons,
                        in: 0...10,
                        step: 1
                    ) {
                        Text("\(paymentViewModel.numberOfLessons)")
                    }
                }
                
                paymentData
                
                Section("Confirmation Number") {
                    TextField("Confirmation Number", text: $paymentViewModel.confirmationNumber)
                }
            }
            .navigationTitle("Payment Entry")
            .navigationBarTitleDisplayMode(.inline)
            .alert(headerMessage, isPresented: $isShowing) {
                Button("Ok") {
                    headerMessage = ""
                    confirmationMessage = ""
                }
            } message: {
                Text(confirmationMessage)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Save", action: onSaveTapped)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
    }
    
    func onSaveTapped() {
        guard let purchasedLesson = paymentViewModel.purchaseLesson() else {
            headerMessage = "Missing Requirement"
            
            if paymentViewModel.selectedStudent == nil {
                confirmationMessage = "Please select a student."
            }
            
            if paymentViewModel.selectedActivitiy == nil {
                confirmationMessage += "\nPlease select an activity"
            }
            
            isShowing = true
            return
        }
        
        modelContext.insert(purchasedLesson)
        
//        let paymentRecord = CloudController.shared.generateCloudRecord(for: purchasedLesson)
//        CloudController.shared.saveRecord(paymentRecord)
        
        dismiss()
    }
 
}


#Preview {
    NavigationStack {
        PaymentFormView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}
