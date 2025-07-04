//
//  ContentView.swift
//  Workout Tracker
//
//  Created by Jaron Wright on 7/3/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            WorkoutSessionView()
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("Sessions")
                }
            
            QuickWorkoutView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Quick Add")
                }
        }
        .accentColor(StarkColors.starkBlue)
    }
}

struct QuickWorkoutView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var workouts: [Workout]
    @State private var newWorkoutName = ""
    @State private var newWorkoutSets = ""
    @State private var newWorkoutReps = ""
    @State private var newWorkoutWeight = ""
    @State private var newWorkoutNotes = ""
    @State private var showAISuggestion = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                StarkColors.heroGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: StarkSpacing.large) {
                        // AI Suggestion Card
                        if showAISuggestion {
                            AISuggestionCard(
                                message: "Based on your recent performance, try increasing your bench press weight by 5 lbs for the next set.",
                                onAccept: {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        showAISuggestion = false
                                    }
                                },
                                onDismiss: {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        showAISuggestion = false
                                    }
                                }
                            )
                            .transition(.move(edge: .top).combined(with: .opacity))
                        }
                        
                        // Workout Input Section
                        VStack(spacing: StarkSpacing.base) {
                            HStack {
                                Text("Add New Workout")
                                    .font(StarkTypography.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                Spacer()
                                
                                Button(action: {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        showAISuggestion.toggle()
                                    }
                                }) {
                                    Image(systemName: "brain.head.profile")
                                        .foregroundColor(StarkColors.starkBlue)
                                        .font(.title2)
                                }
                            }
                            
                            TextField("Exercise Name", text: $newWorkoutName)
                                .glassInputField()
                            
                            HStack(spacing: StarkSpacing.small) {
                                TextField("Sets", text: $newWorkoutSets)
                                    .glassInputField()
                                    .keyboardType(.numberPad)
                                
                                TextField("Reps", text: $newWorkoutReps)
                                    .glassInputField()
                                    .keyboardType(.numberPad)
                                
                                TextField("Weight (lbs)", text: $newWorkoutWeight)
                                    .glassInputField()
                                    .keyboardType(.decimalPad)
                            }
                            
                            TextField("Notes (optional)", text: $newWorkoutNotes)
                                .glassInputField()
                            
                            Button(action: addWorkout) {
                                HStack(spacing: StarkSpacing.small) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.white)
                                    Text("Add Workout")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(StarkSpacing.base)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(StarkColors.starkBlue)
                                )
                                .scaleEffect(newWorkoutName.isEmpty ? 0.95 : 1.0)
                                .opacity(newWorkoutName.isEmpty ? 0.6 : 1.0)
                            }
                            .disabled(newWorkoutName.isEmpty)
                            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: newWorkoutName.isEmpty)
                        }
                        .padding(StarkSpacing.large)
                        .glassCard()
                        .padding(.horizontal, StarkSpacing.base)
                        
                        // Workout List
                        LazyVStack(spacing: StarkSpacing.base) {
                            ForEach(workouts) { workout in
                                WorkoutCard(
                                    workout: workout,
                                    progress: Double.random(in: 0.3...1.0) // Replace with actual progress
                                )
                                .padding(.horizontal, StarkSpacing.base)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button("Delete", role: .destructive) {
                                        deleteWorkout(workout)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, StarkSpacing.large)
                }
            }
            .navigationTitle("Quick Workout")
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
    
    private func deleteWorkout(_ workout: Workout) {
        modelContext.delete(workout)
    }
}

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: StarkSpacing.small) {
            HStack {
                Text(workout.name)
                    .font(StarkTypography.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(workout.sets) sets × \(workout.reps) reps")
                    .font(StarkTypography.callout)
                    .foregroundColor(StarkColors.starkBlue)
            }
            
            if !workout.weight.isEmpty {
                Text("Weight: \(workout.weight) lbs")
                    .font(StarkTypography.subhead)
                    .foregroundColor(.secondary)
            }
            
            if !workout.notes.isEmpty {
                Text(workout.notes)
                    .font(StarkTypography.caption)
                    .foregroundColor(.secondary)
                    .italic()
            }
        }
        .padding(StarkSpacing.base)
        .glassCard()
    }
}

#Preview {
    ContentView()
}
