//
//  LogView.swift
//  LessonTrackerWatch Watch App
//
//  Created by Brenton Niebauer on 4/12/25.
//

import SwiftUI
import SwiftData

struct LogView: View {
    @Query private var payments: [Payment]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Button("Add Payment", action: addPayment)
                
                Divider()
                
                ForEach(payments) { payment in
                    NavigationLink {
                        LogLessonSheet(payment: payment)
                    } label: {
                        Text("\(payment.activity!.name) - \(payment.student!.name) - \(payment.status)")
                    }
                }
            }
        }
    }
    
    func addPayment() {
        
    }
}

#Preview {
    LogView()
        .modelContainer(SampleData.shared.modelContainer)
}
