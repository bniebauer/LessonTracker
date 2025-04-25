//
//  LogLessonSheet.swift
//  LessonTrackerWatch Watch App
//
//  Created by Brenton Niebauer on 4/12/25.
//

import SwiftUI

struct LogLessonSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingConfirmation: Bool = false
    @State private var headerMessage: String = ""
    @State private var confirmationMessage: String = ""
    
    let payment: Payment
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text("\(Date.now.formatted(date: .abbreviated, time: .omitted))")
                    .font(.system(size: 32))
                    .padding([.leading, .trailing])
                
                HStack {
                    
                    ActivityIcon()
                        .padding(.trailing)
                    
                    VStack(alignment: .leading) {
                        
                        Text("\(payment.activity!.name)")
                            .font(.title)
                            .padding(.trailing)
                            .foregroundStyle(.white)
                        
                        Text("\(payment.student!.name)")
                            .font(.headline)
                            .padding(.trailing)
                        
                    }
                    .padding(.trailing)
                    
                }
                
                Button("Attended", action: attendedTapped)
                    .background(.blue.opacity(0.9))
                    .cornerRadius(25)
                    .foregroundStyle(.white)
                
                
            }
            .padding([.top, .bottom, .trailing])
            .background(.gray)
            .border(.black)
            .alert(headerMessage, isPresented: $showingConfirmation) {
                Button("Ok") { }
            } message: {
                Text(confirmationMessage)
            }
            
            Divider()
            
            ForEach(payment.lessons, id: \.self) { lesson in
                Text("\(lesson.formatted(date: .abbreviated, time: .omitted))")
            }
            .onDelete(perform: deleteLesson)
        }
    }
    
    func deleteLesson(at offsets: IndexSet) {
        do {
            try payment.removeLessons(at: offsets)
        } catch {
            // TODO: add additional code
            
        }
    }
    
    func attendedTapped() {
        do {
            try payment.addLesson(Date.now)
        } catch {
            // TODO: Add additional code
            headerMessage = "Uh oh"
            print(error.localizedDescription)
            confirmationMessage = error.localizedDescription
            showingConfirmation = true
        }
    }
}

#Preview {
    LogLessonSheet(payment: SampleData.shared.payment)
}
