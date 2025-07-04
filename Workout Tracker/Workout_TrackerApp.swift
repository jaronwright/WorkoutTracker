//
//  Workout_TrackerApp.swift
//  Workout Tracker
//
//  Created by Jaron Wright on 7/3/25.
//

import SwiftUI
import SwiftData

@main
struct Workout_TrackerApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: WorkoutSession.self)
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
