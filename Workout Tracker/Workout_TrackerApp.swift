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
            let schema = Schema([
                WorkoutSession.self
            ])
            
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: true
            )
            
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
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
