//
//  Models.swift
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
    var dateCreated: Date
    var isCompleted: Bool
    var exercises: [WorkoutExercise]
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.dateCreated = Date()
        self.isCompleted = false
        self.exercises = []
    }
}

@Model
final class WorkoutExercise {
    var id: UUID
    var name: String
    var sets: String
    var reps: String
    var weight: String
    var notes: String
    var session: WorkoutSession?
    
    init(name: String, sets: String, reps: String, weight: String, notes: String) {
        self.id = UUID()
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.notes = notes
    }
}

@Model
final class Workout {
    var id: UUID
    var name: String
    var sets: String
    var reps: String
    var weight: String
    var notes: String
    var dateCreated: Date
    
    init(name: String, sets: String, reps: String, weight: String, notes: String) {
        self.id = UUID()
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.notes = notes
        self.dateCreated = Date()
    }
}

@Model
final class WorkoutTemplate {
    var id: UUID
    var name: String
    var category: String
    var exercises: [TemplateExercise]
    
    init(name: String, category: String, exercises: [TemplateExercise] = []) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.exercises = exercises
    }
}

@Model
final class TemplateExercise {
    var id: UUID
    var name: String
    var sets: String
    var reps: String
    var notes: String
    var isWarmup: Bool
    var template: WorkoutTemplate?
    
    init(name: String, sets: String, reps: String, notes: String, isWarmup: Bool = false) {
        self.id = UUID()
        self.name = name
        self.sets = sets
        self.reps = reps
        self.notes = notes
        self.isWarmup = isWarmup
    }
}