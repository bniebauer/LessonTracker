//
//  LogView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct LogView: View {
    
    var body: some View {
        VStack {
            NavigationLink(destination: PaymentFormView()) {
                Text("Add Payment")
                    .padding()
                    .background(.green)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            NavigationLink(destination: LessonFormView()) {
                Text("Add Lesson")
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
        }
        
    }
    
    func addPayment() {
        
    }
}

#Preview {
    NavigationStack {
        LogView()
    }
}
