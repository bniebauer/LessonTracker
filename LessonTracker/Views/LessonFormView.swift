//
//  LessonFormView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct LessonFormView: View {
    @Query(sort: \Student.age) var students: [Student]
    @Query var payments: [Payment]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if students.isEmpty {
                    ContentUnavailableView {
                        Label("No Students", systemImage: "person.2.slash.fill")
                    } description: {
                        Text("Add Students in Settings Tab.")
                    }
                } else {
                    ForEach(students) { student in
                        Text(student.name)
                        ScrollView(.horizontal) {
                            if student.payments.isEmpty {
                                ContentUnavailableView {
                                    Label("No Lessons", systemImage: "tray.fill")
                                } description: {
                                    Text("Lessons purchased will appear hear.")
                                }
                            } else {
                                HStack {
                                    ForEach(student.payments) { payment in
                                        PunchCardView(student: student, payment: payment)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    LessonFormView()
        .modelContainer(SampleData.shared.modelContainer)
}
