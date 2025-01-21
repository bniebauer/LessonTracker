//
//  PunchCard.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/12/24.
//

import SwiftUI

struct PunchCardView: View {
    var student: Student
    var payment: Payment
    
    @State private var punchCard: PunchCard
    
    @Environment(\.modelContext) private var context
    
    init(student: Student, payment: Payment) {
        self.student = student
        self.payment = payment
        self.punchCard = PunchCard(activity: payment.activity, student: student, totalNumberOfLessons: payment.numberOfLessons, lessons: payment.lessons)
    }
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(width: 375, height: 300)
                .foregroundStyle(.green)
            VStack {
                Spacer()
                
                HStack(spacing: 25) {
                    ForEach(punchCard.topRange, id: \.self) { index in
                        Circle()
                            .stroke(.black, lineWidth: 2)
                            .fill(index+1 <= punchCard.numberOfLessonsCompleted ? .white :.green)
                            .frame(width: 35)
                            .onTapGesture {
                                cardPunched(index: index)
                            }
                    }
                }
                
                HStack {
                    Text(punchCard.title)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 150)
                    Button("", systemImage: "arrow.uturn.backward.circle") {
                        undoPunch()
                    }
                    .bold()
                    .padding(.leading, 10)
                }
                
                HStack(spacing: 25) {
                    ForEach(punchCard.bottomRange, id: \.self) { index in
                        Circle()
                            .stroke(.black, lineWidth: 2)
                            .fill(index+1 <= punchCard.numberOfLessonsCompleted ? .white :.green)
                            .frame(width: 35)
                            .onTapGesture {
                                cardPunched(index: index)
                            }
                    }
                }
                
                Spacer()
            }
        }
    }
    
    private func cardPunched(index: Int) {
        let lesson = punchCard.incrementNumberOfLessonsCompleted(index)
        if let lesson = lesson {
            context.insert(lesson)
            payment.lessons.append(lesson)
        }
    }
    
    private func undoPunch() {
        let lesson = punchCard.undo()
        context.delete(lesson)
    }

}

#Preview {
    PunchCardView(student: Student.sampleData.first!, payment: Payment.sampleData.first!)
}

#Preview("With a lesson") {
    PunchCardView(student: Student.sampleData.first!, payment: Payment.sampleData[2])
}
