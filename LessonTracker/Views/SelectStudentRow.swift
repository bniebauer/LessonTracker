//
//  SelectStudentRow.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/6/24.
//

import SwiftUI

struct SelectStudentRow: View {
    var name: String
    var toggled: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: toggled ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    action()
                }
            Text("\(name)")            
        }
    }
}

#Preview {
    @Previewable @State var toggled: Bool = false
    SelectStudentRow(name: "Kaleb", toggled: toggled) {
        toggled.toggle()
    }
}
