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
    @Query(sort: \Workout.createdAt, order: .reverse) private var workouts: [Workout]
    @State private var selectedWorkout: Workout?
    @State private var showingWorkoutDetail = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                StarkColors.heroGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: StarkSpacing.base) {
                        // Header Stats
                        HStack(spacing: StarkSpacing.large) {
                            StatCard(
                                title: "Total Workouts",
                                value: "\(workouts.count)",
                                icon: "figure.strengthtraining.traditional",
                                color: StarkColors.starkBlue
                            )
                            
                            StatCard(
                                title: "This Week",
                                value: "\(workoutsThisWeek)",
                                icon: "calendar",
                                color: StarkColors.powerOrange
                            )
                        }
                        .padding(.horizontal, StarkSpacing.base)
                        
                        // Workout Sessions
                        ForEach(workouts) { workout in
                            WorkoutSessionCard(workout: workout)
                                .padding(.horizontal, StarkSpacing.base)
                                .onTapGesture {
                                    selectedWorkout = workout
                                    showingWorkoutDetail = true
                                }
                        }
                    }
                    .padding(.vertical, StarkSpacing.large)
                }
            }
            .navigationTitle("Workout Sessions")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingWorkoutDetail) {
                if let workout = selectedWorkout {
                    WorkoutDetailView(workout: workout)
                }
            }
        }
    }
    
    private var workoutsThisWeek: Int {
        let calendar = Calendar.current
        let now = Date()
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: now) ?? now
        
        return workouts.filter { workout in
            workout.createdAt >= weekAgo
        }.count
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: StarkSpacing.small) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(StarkTypography.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(StarkTypography.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(StarkSpacing.base)
        .glassCard()
    }
}

struct WorkoutSessionCard: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: StarkSpacing.small) {
            HStack {
                VStack(alignment: .leading, spacing: StarkSpacing.tiny) {
                    Text(workout.name)
                        .font(StarkTypography.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(formatDate(workout.createdAt))
                        .font(StarkTypography.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Status indicator
                HStack(spacing: StarkSpacing.tiny) {
                    Circle()
                        .fill(workout.isCompleted ? StarkColors.successGreen : StarkColors.warningAmber)
                        .frame(width: 8, height: 8)
                    
                    Text(workout.isCompleted ? "Completed" : "In Progress")
                        .font(StarkTypography.mini)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack(spacing: StarkSpacing.medium) {
                InfoPill(label: "Sets", value: workout.sets)
                InfoPill(label: "Reps", value: workout.reps)
                if !workout.weight.isEmpty {
                    InfoPill(label: "Weight", value: "\(workout.weight) lbs")
                }
            }
            
            if !workout.notes.isEmpty {
                Text(workout.notes)
                    .font(StarkTypography.caption)
                    .foregroundColor(.secondary)
                    .italic()
                    .padding(.top, StarkSpacing.tiny)
            }
        }
        .padding(StarkSpacing.base)
        .glassCard()
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct InfoPill: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 2) {
            Text(label)
                .font(StarkTypography.mini)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(StarkTypography.callout)
                .fontWeight(.medium)
                .foregroundColor(StarkColors.starkBlue)
        }
        .padding(.horizontal, StarkSpacing.small)
        .padding(.vertical, StarkSpacing.tiny)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(StarkColors.starkBlue.opacity(0.1))
        )
    }
}

struct WorkoutDetailView: View {
    let workout: Workout
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                StarkColors.heroGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: StarkSpacing.large) {
                        // Workout Details
                        VStack(alignment: .leading, spacing: StarkSpacing.base) {
                            Text("Workout Details")
                                .font(StarkTypography.title2)
                                .fontWeight(.semibold)
                            
                            DetailRow(label: "Exercise", value: workout.name)
                            DetailRow(label: "Sets", value: workout.sets)
                            DetailRow(label: "Reps", value: workout.reps)
                            if !workout.weight.isEmpty {
                                DetailRow(label: "Weight", value: "\(workout.weight) lbs")
                            }
                            DetailRow(label: "Created", value: formatDate(workout.createdAt))
                            if let completedAt = workout.completedAt {
                                DetailRow(label: "Completed", value: formatDate(completedAt))
                            }
                            
                            if !workout.notes.isEmpty {
                                VStack(alignment: .leading, spacing: StarkSpacing.tiny) {
                                    Text("Notes")
                                        .font(StarkTypography.callout)
                                        .fontWeight(.medium)
                                        .foregroundColor(.secondary)
                                    
                                    Text(workout.notes)
                                        .font(StarkTypography.body)
                                        .foregroundColor(.primary)
                                }
                                .padding(.top, StarkSpacing.small)
                            }
                        }
                        .padding(StarkSpacing.large)
                        .glassCard()
                        .padding(.horizontal, StarkSpacing.base)
                    }
                    .padding(.vertical, StarkSpacing.large)
                }
            }
            .navigationTitle("Workout Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(StarkTypography.callout)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(StarkTypography.callout)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    WorkoutSessionView()
}