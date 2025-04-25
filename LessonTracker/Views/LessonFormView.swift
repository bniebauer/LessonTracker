//
//  LessonFormView.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 9/16/24.
//

import SwiftUI
import SwiftData

struct LessonFormView: View {
    @Query private var payments: [Payment]
    
    var body: some View {
        NavigationStack {
            ForEach(payments) { payment in
                LessonCard(payment: payment)
            }
        }
    }
}

#Preview {
    LessonFormView()
        .modelContainer(SampleData.shared.modelContainer)
}
