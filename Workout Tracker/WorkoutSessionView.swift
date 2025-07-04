//
//  WorkoutSessionView.swift
//  Workout Tracker
//
//  Created by Jaron Wright on 7/3/25.
//

import SwiftUI
import SwiftData

struct WorkoutSessionView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var workoutSessions: [WorkoutSession]
    @State private var showingNewSession = false
    @State private var newSessionName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(workoutSessions) { session in
                        NavigationLink(destination: SessionDetailView(session: session)) {
                            WorkoutSessionRow(session: session)
                        }
                    }
                    .onDelete(perform: deleteSession)
                }
                .listStyle(PlainListStyle())
                
                Button(action: {
                    showingNewSession = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                        Text("Start New Workout")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Workout Sessions")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingNewSession) {
                NewWorkoutSessionView(onSave: { sessionName in
                    createNewSession(name: sessionName)
                    showingNewSession = false
                })
            }
        }
    }
    
    private func createNewSession(name: String) {
        let newSession = WorkoutSession(name: name)
        modelContext.insert(newSession)
    }
    
    private func deleteSession(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(workoutSessions[index])
        }
    }
}

struct WorkoutSessionRow: View {
    let session: WorkoutSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(session.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(session.exercises.count) exercises")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text(session.dateCreated, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text(session.isCompleted ? "Completed" : "In Progress")
                    .font(.caption)
                    .foregroundColor(session.isCompleted ? .green : .orange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(session.isCompleted ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                    )
            }
        }
        .padding(.vertical, 4)
    }
}

struct NewWorkoutSessionView: View {
    @State private var sessionName = ""
    let onSave: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Workout Session Name", text: $sessionName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Spacer()
            }
            .navigationTitle("New Workout Session")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(sessionName)
                    }
                    .disabled(sessionName.isEmpty)
                }
            }
        }
    }
}

struct SessionDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let session: WorkoutSession
    @State private var showingAddExercise = false
    @State private var newExerciseName = ""
    @State private var newExerciseSets = ""
    @State private var newExerciseReps = ""
    @State private var newExerciseWeight = ""
    @State private var newExerciseNotes = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(session.exercises) { exercise in
                    WorkoutExerciseRow(exercise: exercise)
                }
                .onDelete(perform: deleteExercise)
            }
            .listStyle(PlainListStyle())
            
            Button(action: {
                showingAddExercise = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                    Text("Add Exercise")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
            }
            .padding()
            
            Button(action: {
                session.isCompleted.toggle()
            }) {
                HStack {
                    Image(systemName: session.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(.white)
                    Text(session.isCompleted ? "Mark Incomplete" : "Complete Workout")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(session.isCompleted ? Color.orange : Color.blue)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationTitle(session.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddExercise) {
            AddExerciseView(onSave: { name, sets, reps, weight, notes in
                addExercise(name: name, sets: sets, reps: reps, weight: weight, notes: notes)
                showingAddExercise = false
            })
        }
    }
    
    private func addExercise(name: String, sets: String, reps: String, weight: String, notes: String) {
        let exercise = WorkoutExercise(name: name, sets: sets, reps: reps, weight: weight, notes: notes)
        exercise.session = session
        session.exercises.append(exercise)
        modelContext.insert(exercise)
    }
    
    private func deleteExercise(offsets: IndexSet) {
        for index in offsets {
            let exercise = session.exercises[index]
            session.exercises.remove(at: index)
            modelContext.delete(exercise)
        }
    }
}

struct WorkoutExerciseRow: View {
    let exercise: WorkoutExercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(exercise.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(exercise.sets) sets × \(exercise.reps) reps")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if !exercise.weight.isEmpty {
                Text("Weight: \(exercise.weight) lbs")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if !exercise.notes.isEmpty {
                Text(exercise.notes)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .italic()
            }
        }
        .padding(.vertical, 4)
    }
}

struct AddExerciseView: View {
    @State private var exerciseName = ""
    @State private var exerciseSets = ""
    @State private var exerciseReps = ""
    @State private var exerciseWeight = ""
    @State private var exerciseNotes = ""
    
    let onSave: (String, String, String, String, String) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                TextField("Exercise Name", text: $exerciseName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    TextField("Sets", text: $exerciseSets)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    TextField("Reps", text: $exerciseReps)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    TextField("Weight (lbs)", text: $exerciseWeight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                TextField("Notes (optional)", text: $exerciseNotes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(exerciseName, exerciseSets, exerciseReps, exerciseWeight, exerciseNotes)
                    }
                    .disabled(exerciseName.isEmpty)
                }
            }
        }
    }
}

#Preview {
    WorkoutSessionView()
}