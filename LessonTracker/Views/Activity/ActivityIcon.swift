//
//  ActivityIcon.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 4/12/25.
//

import SwiftUI

struct ActivityIcon: View {
    let iconName: String? = nil
    let defaultIconName: String = "calendar.badge.clock"
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 21)
                .fill(Color.blue)
                .frame(width: 80, height: 80)
            
            Image(systemName: iconName ?? defaultIconName)
                .font(.system(size: 42))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ActivityIcon()
}
