//
//  LogView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct LogView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var payments: [Payment]
    @State private var path = NavigationPath()
    @State private var isShowing: Bool = false
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(payments) { payment in
                    NavigationLink {
                        LogLessonSheet(payment: payment)
                    } label: {
                        Text("\(payment.activity.name) - \(payment.student.name) - \(payment.status)")
                    }
                }
            }
            .navigationTitle("LessonTracker")
            .toolbar {
                Button("Add Payment", action: addPayment)
            }
            .sheet(isPresented: $isShowing) {
                PaymentFormView()
            }
        }
    }
    
    func addPayment() {
        isShowing = true
    }

}


#Preview {
    LogView()
        .modelContainer(SampleData.shared.modelContainer)
}
