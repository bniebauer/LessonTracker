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
    var price: Double = 0.0
    var numberOfLessonsPerPayment: Int = 1
    var imageString: String?
    
    init(name: String, price: Double, numberOfLessonsPerPayment: Int = 1, imageString: String? = nil) {
        self.name = name
        self.price = price
        self.numberOfLessonsPerPayment = numberOfLessonsPerPayment
        self.imageString = imageString
    }
}

extension Activity {
    static let sampleData = [
        Activity(name: "D1", price: 100.00),
        Activity(name: "Tennis Beginner", price: 110.00, numberOfLessonsPerPayment: 4),
        Activity(name: "Tennis Advanced", price: 165.00, numberOfLessonsPerPayment: 4),
        Activity(name: "Aerial Silks", price: 190.00, numberOfLessonsPerPayment: 6)
    ]
}
