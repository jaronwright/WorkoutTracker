//
//  WorkoutTemplates.swift
//  Workout Tracker
//
//  Created by Jaron Wright on 7/3/25.
//

import Foundation

struct WorkoutTemplateData {
    static let templates: [WorkoutTemplateInfo] = [
        // PULL A
        WorkoutTemplateInfo(
            name: "PULL A",
            category: "Upper Body",
            exercises: [
                // Warm-up
                TemplateExerciseInfo(name: "Rowing Machine", sets: "1", reps: "5 min", notes: "Moderate pace", isWarmup: true),
                TemplateExerciseInfo(name: "Band Face Pulls", sets: "2", reps: "15", notes: "Activate rear delts", isWarmup: true),
                TemplateExerciseInfo(name: "Scapular Pull-ups", sets: "2", reps: "10", notes: "Bodyweight", isWarmup: true),
                
                // Main Workout
                TemplateExerciseInfo(name: "Pull-Ups", sets: "4", reps: "6-10", notes: "2-3 min rest"),
                TemplateExerciseInfo(name: "Barbell Row", sets: "4", reps: "8", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Cable Pulldown", sets: "3", reps: "12", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Cable Row", sets: "3", reps: "12", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "EZ Bar Curl", sets: "3", reps: "10", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Hammer Curls", sets: "3", reps: "12", notes: "60 sec rest"),
                
                // ABS
                TemplateExerciseInfo(name: "Woodchoppers", sets: "3", reps: "15/side", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Russian Twists", sets: "3", reps: "30", notes: "45 sec rest"),
                
                // Burnout
                TemplateExerciseInfo(name: "Barbell Curl Burnout", sets: "1", reps: "Failure", notes: "Light weight")
            ]
        ),
        
        // LEGS A
        WorkoutTemplateInfo(
            name: "LEGS A",
            category: "Lower Body",
            exercises: [
                // Warm-up
                TemplateExerciseInfo(name: "Bike", sets: "1", reps: "5 min", notes: "Easy pace", isWarmup: true),
                TemplateExerciseInfo(name: "Air Squats", sets: "2", reps: "20", notes: "Dynamic", isWarmup: true),
                TemplateExerciseInfo(name: "Leg Swings", sets: "2", reps: "10/leg", notes: "Each direction", isWarmup: true),
                
                // Main Workout
                TemplateExerciseInfo(name: "Back Squat", sets: "4", reps: "6-8", notes: "3 min rest"),
                TemplateExerciseInfo(name: "Front Squat", sets: "3", reps: "8-10", notes: "2 min rest"),
                TemplateExerciseInfo(name: "Hip Thrusts", sets: "3", reps: "12-15", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Leg Extension", sets: "3", reps: "15", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Walking Lunges", sets: "3", reps: "20 steps", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Standing Calf Raises", sets: "4", reps: "15", notes: "45 sec rest"),
                
                // ABS
                TemplateExerciseInfo(name: "Plank", sets: "3", reps: "45s", notes: "45 sec rest"),
                
                // Finisher
                TemplateExerciseInfo(name: "Leg Extension Burnout", sets: "1", reps: "30+", notes: "Drop weight 2x")
            ]
        ),
        
        // PUSH A
        WorkoutTemplateInfo(
            name: "PUSH A",
            category: "Upper Body",
            exercises: [
                // Warm-up
                TemplateExerciseInfo(name: "Incline Treadmill Walk", sets: "1", reps: "5 min", notes: "3% incline", isWarmup: true),
                TemplateExerciseInfo(name: "Push-ups", sets: "2", reps: "15", notes: "Controlled tempo", isWarmup: true),
                TemplateExerciseInfo(name: "Band Pull-aparts", sets: "2", reps: "15", notes: "Light band", isWarmup: true),
                
                // Main Workout
                TemplateExerciseInfo(name: "Barbell Bench Press", sets: "4", reps: "6-8", notes: "2-3 min rest"),
                TemplateExerciseInfo(name: "Incline DB Press", sets: "3", reps: "8-10", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Cable Fly", sets: "3", reps: "12-15", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Weighted Dips", sets: "3", reps: "8-10", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Rope Pushdowns", sets: "3", reps: "12-15", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Diamond Push-ups", sets: "3", reps: "12-15", notes: "60 sec rest"),
                
                // ABS
                TemplateExerciseInfo(name: "Hanging Leg Raises", sets: "3", reps: "15", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Cable Crunches", sets: "3", reps: "20", notes: "45 sec rest"),
                
                // Burnout
                TemplateExerciseInfo(name: "Push-Up Burnout", sets: "1", reps: "Failure", notes: "To failure")
            ]
        ),
        
        // PULL B
        WorkoutTemplateInfo(
            name: "PULL B",
            category: "Upper Body",
            exercises: [
                // Warm-up
                TemplateExerciseInfo(name: "Incline Treadmill Walk", sets: "1", reps: "5 min", notes: "3% incline", isWarmup: true),
                TemplateExerciseInfo(name: "Band Rows", sets: "2", reps: "20", notes: "Light band", isWarmup: true),
                TemplateExerciseInfo(name: "Cat-Cow Stretches", sets: "2", reps: "10", notes: "Mobility", isWarmup: true),
                
                // Main Workout
                TemplateExerciseInfo(name: "Deadlifts", sets: "4", reps: "5", notes: "3 min rest"),
                TemplateExerciseInfo(name: "T-Bar Row", sets: "3", reps: "8-10", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Seated Cable Row", sets: "3", reps: "12", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Shrugs", sets: "3", reps: "12", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Preacher Curls", sets: "3", reps: "10", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Cable Curls", sets: "3", reps: "12", notes: "60 sec rest"),
                
                // ABS
                TemplateExerciseInfo(name: "Ab Wheel", sets: "3", reps: "12", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Side Plank", sets: "3", reps: "30s/side", notes: "45 sec rest"),
                
                // Burnout
                TemplateExerciseInfo(name: "Cable Curl 21s", sets: "1", reps: "1 set", notes: "7-7-7 reps")
            ]
        ),
        
        // LEGS B
        WorkoutTemplateInfo(
            name: "LEGS B",
            category: "Lower Body",
            exercises: [
                // Warm-up
                TemplateExerciseInfo(name: "Stairmaster", sets: "1", reps: "5 min", notes: "Moderate", isWarmup: true),
                TemplateExerciseInfo(name: "Good Mornings", sets: "2", reps: "15", notes: "Bodyweight", isWarmup: true),
                TemplateExerciseInfo(name: "Glute Bridges", sets: "2", reps: "20", notes: "Activation", isWarmup: true),
                
                // Main Workout
                TemplateExerciseInfo(name: "Romanian Deadlift", sets: "4", reps: "8", notes: "2-3 min rest"),
                TemplateExerciseInfo(name: "Lying Leg Curls", sets: "4", reps: "10-12", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Hip Thrusts", sets: "3", reps: "12-15", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Reverse Lunges", sets: "3", reps: "12/leg", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Single-Leg RDL", sets: "3", reps: "10/leg", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Seated Calf Raises", sets: "4", reps: "20", notes: "45 sec rest"),
                
                // ABS
                TemplateExerciseInfo(name: "Hanging Leg Raises", sets: "3", reps: "15", notes: "60 sec rest"),
                
                // Finisher
                TemplateExerciseInfo(name: "Walking Lunges", sets: "1", reps: "50 total steps", notes: "Bodyweight")
            ]
        ),
        
        // PUSH B
        WorkoutTemplateInfo(
            name: "PUSH B",
            category: "Upper Body",
            exercises: [
                // Warm-up
                TemplateExerciseInfo(name: "Jump Rope", sets: "2", reps: "1 min", notes: "30s rest", isWarmup: true),
                TemplateExerciseInfo(name: "Arm Circles", sets: "2", reps: "20", notes: "Both directions", isWarmup: true),
                TemplateExerciseInfo(name: "Light Overhead Press", sets: "2", reps: "10", notes: "Empty bar", isWarmup: true),
                
                // Main Workout
                TemplateExerciseInfo(name: "Overhead Press", sets: "4", reps: "6-8", notes: "2-3 min rest"),
                TemplateExerciseInfo(name: "DB Shoulder Press", sets: "3", reps: "10", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Lateral Raises", sets: "3", reps: "15", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Rear Delt Fly", sets: "3", reps: "12", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "Close-Grip Bench", sets: "3", reps: "10", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Weighted Dips", sets: "3", reps: "8-10", notes: "90 sec rest"),
                TemplateExerciseInfo(name: "Overhead Cable Extension", sets: "3", reps: "12-15", notes: "60 sec rest"),
                
                // ABS
                TemplateExerciseInfo(name: "Hanging Knee Raises", sets: "3", reps: "15", notes: "60 sec rest"),
                TemplateExerciseInfo(name: "V-Ups", sets: "3", reps: "15", notes: "45 sec rest"),
                
                // Burnout
                TemplateExerciseInfo(name: "Lateral Raise 21s", sets: "1", reps: "1 set", notes: "7-7-7 reps")
            ]
        )
    ]
}

struct WorkoutTemplateInfo {
    let name: String
    let category: String
    let exercises: [TemplateExerciseInfo]
}

struct TemplateExerciseInfo {
    let name: String
    let sets: String
    let reps: String
    let notes: String
    let isWarmup: Bool
    
    init(name: String, sets: String, reps: String, notes: String, isWarmup: Bool = false) {
        self.name = name
        self.sets = sets
        self.reps = reps
        self.notes = notes
        self.isWarmup = isWarmup
    }
}