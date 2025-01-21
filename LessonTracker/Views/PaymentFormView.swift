//
//  PaymentFormView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct PaymentFormView: View {
    @Query(sort: \Student.name) private var students: [Student]
    @Query(sort: \Activity.name) private var activities: [Activity]
    @Environment(\.modelContext) private var modelContext
    
    @StateObject var vm: ViewModel = ViewModel()
    
    var activityLabel: String {
        get {
            vm.selectedActivitiy?.name ?? "Select Activity"
        }
    }
    
    var body: some View {
        Form {
            Section("Activity") {
                
                Picker(selection: $vm.selectedActivitiy, label: Text("\(activityLabel)")) {
                    ForEach(activities, id: \.self) { activitiy in
                            Text("\(activitiy.name)").tag(activitiy)
                    }
                }
                
                Stepper("Number of lessons: \(vm.numberOfLessons)", value: $vm.numberOfLessons, in: 0...10)
            }
            
            Section("Amount") {
                TextField("Amount", value: $vm.amount, format: .currency(code: "USD"))
                Picker(selection: $vm.selectedPaymentType, label: Text("\(vm.selectedPaymentType)")) {
                    ForEach(PaymentType.allCases, id: \.self) { paymentType in
                        Text("\(paymentType)").tag(paymentType)
                    }
                }
                DatePicker("Payment Date", selection: $vm.selectedDate, displayedComponents: [.date])
            }
            
            Section("Students") {
                List {
                    ForEach(students) { student in
                        let isSelected = vm.selectedStudents.contains(student)
                        SelectStudentRow(name: student.name, toggled: isSelected) {
                            if !isSelected {
                                vm.selectedStudents.append(student)
                            } else {
                                vm.selectedStudents.removeAll(where: { $0 == student })
                            }
                        }
                    }
                }
            }
            
            Section("Confirmation Number") {
                TextField("Confirmation Number", text: $vm.confirmationNumber)
            }
            
            Button("Save Payment") {
                let purchasedLesson = vm.purchaseLesson()
                modelContext.insert(purchasedLesson)
                
                vm.resetFields()
            }
        }
        .navigationTitle("Payment Entry")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

extension PaymentFormView {
    
    public class ViewModel: ObservableObject {
        @Published var selectedStudents: [Student] = []
        @Published var selectedActivitiy: Activity?
        @Published var numberOfLessons: Int = 0
        @Published var amount: Double = 0
        @Published var selectedPaymentType: PaymentType = PaymentType.Cash
        @Published var selectedDate: Date = Date()
        @Published var confirmationNumber: String = ""
        
        func purchaseLesson() -> Payment {
            let purchasedLesson = Payment(activity: selectedActivitiy!, numberOfLessons: numberOfLessons, amount: amount, type: selectedPaymentType, date: selectedDate, confirmation: confirmationNumber)
            purchasedLesson.students = selectedStudents
            
            return purchasedLesson
        }
        
        func resetFields() {
            selectedStudents = []
            selectedActivitiy = nil
            numberOfLessons = 0
            amount = 0
            selectedPaymentType = PaymentType.Cash
            selectedDate = Date()
            confirmationNumber = ""
        }
    }
}

#Preview {
    PaymentFormView()
        .modelContainer(SampleData.shared.modelContainer)
}
