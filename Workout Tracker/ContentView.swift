//
//  ContentView.swift
//  Workout Tracker
//
//  Created by Jaron Wright on 7/3/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var workouts: [Workout]
    @State private var newWorkoutName = ""
    @State private var newWorkoutSets = ""
    @State private var newWorkoutReps = ""
    @State private var newWorkoutWeight = ""
    @State private var newWorkoutNotes = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Workout Input Section
                VStack(spacing: 12) {
                    Text("Add New Workout")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Exercise Name", text: $newWorkoutName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    HStack {
                        TextField("Sets", text: $newWorkoutSets)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        
                        TextField("Reps", text: $newWorkoutReps)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        
                        TextField("Weight (lbs)", text: $newWorkoutWeight)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                    }
                    
                    TextField("Notes (optional)", text: $newWorkoutNotes)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: addWorkout) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.white)
                            Text("Add Workout")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .disabled(newWorkoutName.isEmpty)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Workout List
                List {
                    ForEach(workouts) { workout in
                        WorkoutRow(workout: workout)
                    }
                    .onDelete(perform: deleteWorkout)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Workout Tracker")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func addWorkout() {
        let workout = Workout(
            name: newWorkoutName,
            sets: newWorkoutSets,
            reps: newWorkoutReps,
            weight: newWorkoutWeight,
            notes: newWorkoutNotes
        )
        
        modelContext.insert(workout)
        
        // Clear input fields
        newWorkoutName = ""
        newWorkoutSets = ""
        newWorkoutReps = ""
        newWorkoutWeight = ""
        newWorkoutNotes = ""
    }
    
    private func deleteWorkout(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(workouts[index])
        }
    }
}

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(workout.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(workout.sets) sets × \(workout.reps) reps")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if !workout.weight.isEmpty {
                Text("Weight: \(workout.weight) lbs")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if !workout.notes.isEmpty {
                Text(workout.notes)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .italic()
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
