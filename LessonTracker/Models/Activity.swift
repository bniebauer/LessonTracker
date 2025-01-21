//
//  Activity.swift
//  LessonTracker
//
//  Created by Brenton Niebauer on 11/11/24.
//

import Foundation
import SwiftData


@Model
class Activity {
    var name: String = "Unknown"
    var imageString: String?
    
    init(name: String, imageString: String? = nil) {
        self.name = name
        self.imageString = imageString
    }
}

extension Activity {
    static let sampleData = [
        Activity(name: "D1" ),
        Activity(name: "Tennis"),
        Activity(name: "Aerial Silks")
    ]
}
