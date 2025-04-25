//
//  Activity.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/11/24.
//

import Foundation
import SwiftData


@Model
class Activity: Identifiable {
    var id = UUID()
    var name: String = "Unknown"
    var imageString: String?
    
    @Relationship(inverse: \Payment.activity)
    var payments: [Payment]?
    
    init(name: String, imageString: String? = nil) {
        self.name = name
        self.imageString = imageString
        self.payments = []
    }
}

extension Activity {
    static let sampleData = [
        Activity(name: "D1"),
        Activity(name: "Tennis Beginner"),
        Activity(name: "Tennis Advanced"),
        Activity(name: "Aerial Silks")
    ]
}
