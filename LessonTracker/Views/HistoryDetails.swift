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
                VStack {
                    Text(payment.student.name)
                    Text(payment.activity.name)
                        .bold()
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("$\(payment.activity.price.formatted(.currency(code: "USD")))")
                    Text(payment.date, format: Date.FormatStyle(date: .numeric))
                }
            }
            .font(.title)
            
            Section("Lessons") {
                ForEach(payment.lessons, id: \.self) { lesson in
                    Text("\(lesson)")
                }                
            }
        }
        .navigationTitle("History Details")
    }
    
}

#Preview {
    NavigationStack {
        HistoryDetails(payment: Payment.sampleData[0])
    }
}
