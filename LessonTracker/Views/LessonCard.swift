//
//  LessonCard.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 1/27/25.
//

import SwiftData
import SwiftUI

struct LessonCard: View {
    @Bindable var payment: Payment
    private let backgroundColor: Color = .purple
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Undo", systemImage: "arrow.uturn.backward.circle", action: undo)
            }
            
            Text("\(payment.student.name)")
                .font(.title)
            Text("\(payment.lessonsCompleted) / \(payment.activity.numberOfLessonsPerPayment)")
                .font(.headline)
            
            Button("Log Lesson", action: incrementLessonsCompleted)
        }
        .padding()
        .foregroundStyle(.white)
        .background(backgroundColor)
    }
    
    func incrementLessonsCompleted() {
        if payment.lessons.count < payment.activity.numberOfLessonsPerPayment {
            do {
                try payment.addLesson(.now)
            } catch {
                // TODO: add additional error checking code
            }
        }
    }
    
    func undo() {
        if payment.lessons.count > 0 {
            do {
                try payment.removeLesson()
            } catch {
                // TODO: add additional error checking
            }
        }
    }
}

