//
//  HistoryDetails.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/18/24.
//

import SwiftUI

struct HistoryDetails: View {
    let payment: Payment
    var body: some View {
        Form {
            HStack {
                Text(payment.activity.name)
                    .bold()
                Spacer()
                Text("$\(payment.amount.formatted())")
                Spacer()
                Text(payment.date, format: Date.FormatStyle(date: .numeric))
            }
            .font(.title)
            
            Section("Lessons") {
                ForEach(payment.lessons) { lesson in
                    Text("\(lesson.timestamp)")
                }
            }
            
            Section("Students") {
                if !payment.students.isEmpty {
                    ForEach(payment.students) { student in
                        Text(student.name)
                    }
                }
            }
        }
        .navigationTitle("History Details")
    }
    
}

#Preview {
    NavigationStack {
        HistoryDetails(payment: Payment.sampleData[1])
    }
}
