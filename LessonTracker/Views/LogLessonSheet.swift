//
//  LogLessonSheet.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 1/29/25.
//

import SwiftUI

struct LogLessonSheet: View {
    @Environment(\.dismiss) private var dismiss
    let payment: Payment
    
    var body: some View {
        VStack {
            VStack {
                    
                    Text("\(Date.now.formatted(date: .abbreviated, time: .omitted))")
                        .font(.title)
                    
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
                            
                            Text("\(payment.activity.name)")
                                .font(.title)
                                .padding(.trailing)
                                .foregroundStyle(.white)
                            
                            Text("\(payment.student.name)")
                                .font(.headline)
                                .padding(.trailing)
                            
                        }
                        .padding(.trailing)
                        
                    }
                
                Button("Attended", action: attendedTapped)
                    .padding(8)
                    .background(.blue.opacity(0.9))
                    .foregroundStyle(.white)
                    .cornerRadius(25)
                    
                }
                .frame(width: 250, height: 175)
                .padding([.top, .bottom, .trailing])
                .background(.gray)
                .border(.black)
            
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
        }
    }
}

#Preview {
    NavigationStack {
        LogLessonSheet(payment: SampleData.shared.payment)
    }
}
