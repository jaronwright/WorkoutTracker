//
//  Workout.swift
//  Workout Tracker
//
//  Created by Jaron Wright on 7/3/25.
//

import Foundation
import SwiftData

@Model
final class WorkoutSession {
    var id: UUID
    var name: String
    var sets: String
    var reps: String
    var weight: String
    var notes: String
    var createdAt: Date
    var completedAt: Date
    var isCompleted: Bool
    
    init(name: String, sets: String, reps: String, weight: String, notes: String) {
        self.id = UUID()
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.notes = notes
        self.createdAt = Date()
        self.completedAt = Date.distantFuture // Use distant future to indicate not completed
        self.isCompleted = false
    }
    
    // Computed property to check if workout is actually completed
    var isActuallyCompleted: Bool {
        return isCompleted && completedAt != Date.distantFuture
    }
} 