//
//  TemplateSelectionView.swift
//  Workout Tracker
//
//  Created by Jaron Wright on 7/3/25.
//

import SwiftUI
import SwiftData

struct TemplateSelectionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let onTemplateSelected: (WorkoutTemplateInfo) -> Void
    
    var body: some View {
        NavigationView {
            List {
                Section("Push Workouts") {
                    ForEach(WorkoutTemplateData.templates.filter { $0.name.contains("PUSH") }, id: \.name) { template in
                        TemplateRow(template: template) {
                            onTemplateSelected(template)
                            dismiss()
                        }
                    }
                }
                
                Section("Pull Workouts") {
                    ForEach(WorkoutTemplateData.templates.filter { $0.name.contains("PULL") }, id: \.name) { template in
                        TemplateRow(template: template) {
                            onTemplateSelected(template)
                            dismiss()
                        }
                    }
                }
                
                Section("Leg Workouts") {
                    ForEach(WorkoutTemplateData.templates.filter { $0.name.contains("LEGS") }, id: \.name) { template in
                        TemplateRow(template: template) {
                            onTemplateSelected(template)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Workout Templates")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct TemplateRow: View {
    let template: WorkoutTemplateInfo
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(template.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("\(template.exercises.count) exercises")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text(template.category)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Show first few exercises as preview
                let mainExercises = template.exercises.filter { !$0.isWarmup }.prefix(3)
                ForEach(Array(mainExercises.enumerated()), id: \.offset) { index, exercise in
                    Text("• \(exercise.name)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                if template.exercises.filter({ !$0.isWarmup }).count > 3 {
                    Text("+ \(template.exercises.filter({ !$0.isWarmup }).count - 3) more exercises")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .italic()
                }
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TemplateDetailView: View {
    let template: WorkoutTemplateInfo
    @Environment(\.dismiss) private var dismiss
    let onStartWorkout: (WorkoutTemplateInfo) -> Void
    
    var body: some View {
        NavigationView {
            List {
                Section("Warm-up") {
                    ForEach(template.exercises.filter { $0.isWarmup }, id: \.name) { exercise in
                        TemplateExerciseRow(exercise: exercise)
                    }
                }
                
                Section("Main Workout") {
                    ForEach(template.exercises.filter { !$0.isWarmup }, id: \.name) { exercise in
                        TemplateExerciseRow(exercise: exercise)
                    }
                }
            }
            .navigationTitle(template.name)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Start Workout") {
                        onStartWorkout(template)
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

struct TemplateExerciseRow: View {
    let exercise: TemplateExerciseInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(exercise.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(exercise.sets) × \(exercise.reps)")
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
        .padding(.vertical, 2)
    }
}

#Preview {
    TemplateSelectionView { template in
        print("Selected: \(template.name)")
    }
}