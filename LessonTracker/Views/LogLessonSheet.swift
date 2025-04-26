//
//  LogLessonSheet.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 1/29/25.
//

import SwiftUI

struct LogLessonSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingConfirmation: Bool = false
    @State private var headerMessage: String = ""
    @State private var confirmationMessage: String = ""
    
    let payment: Payment
    var headerCard: some View {
        VStack {
                
                Text("\(Date.now.formatted(date: .abbreviated, time: .omitted))")
                    .font(.title)
                    .foregroundStyle(.white)
                
                HStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 21)
                            .fill(Color.blue)
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "calendar.badge.clock")
                            .font(.system(size: 42))
                            .foregroundStyle(.white)
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Text("\(payment.activity!.name)")
                            .font(.title)
                            .padding(.trailing)
                            .foregroundStyle(.white)
                        
                        Text("\(payment.student!.name)")
                            .font(.headline)
                            .padding(.trailing)
                            .foregroundStyle(.white)
                        
                    }
                    .padding(.trailing)
                    
                }
            
            Button("Attended", action: attendedTapped)
                .padding(8)
                .background(.blue.opacity(0.9))
                .foregroundStyle(.white)
                .cornerRadius(25)
                
            }
        .frame(width: 350)
        .padding([.top, .bottom, .trailing])
        .background(.gray)
        .border(.black)
        .alert(headerMessage, isPresented: $showingConfirmation) {
            Button("Ok") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    var body: some View {
        VStack {
            headerCard
            
            List {
                Section("History") {
                    ForEach(payment.lessons, id: \.self) { lesson in
                        Text("\(lesson.formatted(date: .abbreviated, time: .omitted))")
                    }
                    .onDelete(perform: deleteLesson)
                }
            }
        }
        .padding([.top])
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
    NavigationStack {
        LogLessonSheet(payment: SampleData.shared.payment)
    }
}
