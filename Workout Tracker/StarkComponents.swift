//
//  StarkComponents.swift
//  Workout Tracker
//
//  Created by Jaron Wright on 7/3/25.
//

import SwiftUI

// MARK: - Workout Glass Card

struct WorkoutGlassCard: View {
    let workout: Workout
    let onTap: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            HapticManager.shared.lightImpact()
            onTap()
        }) {
            VStack(alignment: .leading, spacing: StarkDesign.Spacing.base) {
                HStack {
                    VStack(alignment: .leading, spacing: StarkDesign.Spacing.tiny) {
                        Text(workout.name)
                            .font(StarkDesign.Typography.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        HStack(spacing: StarkDesign.Spacing.tiny) {
                            Text("\(workout.sets) × \(workout.reps)")
                                .font(StarkDesign.Typography.callout)
                                .foregroundColor(StarkDesign.Colors.starkBlue)
                            
                            if !workout.weight.isEmpty {
                                Text("• \(workout.weight) lbs")
                                    .font(StarkDesign.Typography.callout)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Progress indicator
                    Circle()
                        .fill(StarkDesign.Colors.successGreen)
                        .frame(width: 12, height: 12)
                        .overlay(
                            Circle()
                                .stroke(StarkDesign.Colors.successGreen.opacity(0.3), lineWidth: 3)
                                .scaleEffect(1.5)
                        )
                }
                
                if !workout.notes.isEmpty {
                    Text(workout.notes)
                        .font(StarkDesign.Typography.caption)
                        .foregroundColor(.secondary)
                        .italic()
                        .lineLimit(2)
                }
                
                // Timestamp
                HStack {
                    Image(systemName: "clock")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    
                    Text(workout.dateCreated, style: .time)
                        .font(StarkDesign.Typography.mini)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
            }
            .padding(StarkDesign.Spacing.base)
        }
        .buttonStyle(PlainButtonStyle())
        .glassCard()
        .liquidScale(pressed: isPressed)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
}

// MARK: - Session Glass Card

struct SessionGlassCard: View {
    let session: WorkoutSession
    let onTap: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            HapticManager.shared.lightImpact()
            onTap()
        }) {
            VStack(alignment: .leading, spacing: StarkDesign.Spacing.base) {
                HStack {
                    VStack(alignment: .leading, spacing: StarkDesign.Spacing.tiny) {
                        Text(session.name)
                            .font(StarkDesign.Typography.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Text("\(session.exercises.count) exercises")
                            .font(StarkDesign.Typography.callout)
                            .foregroundColor(StarkDesign.Colors.starkBlue)
                    }
                    
                    Spacer()
                    
                    // Progress ring
                    ZStack {
                        ProgressRing(
                            progress: session.isCompleted ? 1.0 : Double(completedExercises) / Double(max(session.exercises.count, 1)),
                            color: session.isCompleted ? StarkDesign.Colors.successGreen : StarkDesign.Colors.starkBlue,
                            lineWidth: 4
                        )
                        .frame(width: 40, height: 40)
                        
                        if session.isCompleted {
                            Image(systemName: "checkmark")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(StarkDesign.Colors.successGreen)
                        } else {
                            Text("\(completedExercises)")
                                .font(StarkDesign.Typography.mini)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    
                    Text(session.dateCreated, style: .date)
                        .font(StarkDesign.Typography.mini)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    // Status pill
                    HStack(spacing: StarkDesign.Spacing.tiny) {
                        Circle()
                            .fill(session.isCompleted ? StarkDesign.Colors.successGreen : StarkDesign.Colors.warningAmber)
                            .frame(width: 6, height: 6)
                        
                        Text(session.isCompleted ? "Completed" : "In Progress")
                            .font(StarkDesign.Typography.mini)
                            .foregroundColor(session.isCompleted ? StarkDesign.Colors.successGreen : StarkDesign.Colors.warningAmber)
                    }
                    .padding(.horizontal, StarkDesign.Spacing.small)
                    .padding(.vertical, StarkDesign.Spacing.tiny)
                    .background(
                        RoundedRectangle(cornerRadius: StarkDesign.CornerRadius.small)
                            .fill((session.isCompleted ? StarkDesign.Colors.successGreen : StarkDesign.Colors.warningAmber).opacity(0.1))
                    )
                }
            }
            .padding(StarkDesign.Spacing.base)
        }
        .buttonStyle(PlainButtonStyle())
        .glassCard()
        .liquidScale(pressed: isPressed)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
    
    private var completedExercises: Int {
        // Simplified logic - in real app you'd track completion per exercise
        session.isCompleted ? session.exercises.count : session.exercises.count / 2
    }
}

// MARK: - Exercise Row Glass Card

struct ExerciseGlassCard: View {
    let exercise: WorkoutExercise
    let onTap: () -> Void
    
    @State private var isPressed = false
    @State private var isCompleted = false
    
    var body: some View {
        HStack(spacing: StarkDesign.Spacing.base) {
            // Completion indicator
            Button(action: {
                HapticManager.shared.mediumImpact()
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    isCompleted.toggle()
                }
            }) {
                ZStack {
                    Circle()
                        .fill(isCompleted ? StarkDesign.Colors.successGreen : StarkDesign.Colors.surfaceGlass)
                        .frame(width: 32, height: 32)
                    
                    if isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .transition(.scale.combined(with: .opacity))
                    } else {
                        Circle()
                            .stroke(StarkDesign.Colors.starkBlue.opacity(0.5), lineWidth: 2)
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            // Exercise details
            VStack(alignment: .leading, spacing: StarkDesign.Spacing.tiny) {
                Text(exercise.name)
                    .font(StarkDesign.Typography.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .strikethrough(isCompleted)
                
                HStack(spacing: StarkDesign.Spacing.small) {
                    Text("\(exercise.sets) × \(exercise.reps)")
                        .font(StarkDesign.Typography.caption)
                        .foregroundColor(StarkDesign.Colors.starkBlue)
                    
                    if !exercise.weight.isEmpty {
                        Text("• \(exercise.weight) lbs")
                            .font(StarkDesign.Typography.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                if !exercise.notes.isEmpty {
                    Text(exercise.notes)
                        .font(StarkDesign.Typography.mini)
                        .foregroundColor(.secondary)
                        .italic()
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            // Action button
            Button(action: {
                HapticManager.shared.lightImpact()
                onTap()
            }) {
                Image(systemName: "pencil")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(StarkDesign.Colors.starkBlue)
                    .frame(width: 32, height: 32)
                    .background(
                        Circle()
                            .fill(StarkDesign.Colors.starkBlue.opacity(0.1))
                    )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(StarkDesign.Spacing.base)
        .glassCard(cornerRadius: StarkDesign.CornerRadius.medium)
        .opacity(isCompleted ? 0.7 : 1.0)
        .animation(.easeInOut(duration: 0.3), value: isCompleted)
    }
}

// MARK: - Template Glass Card

struct TemplateGlassCard: View {
    let template: WorkoutTemplateInfo
    let onTap: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            HapticManager.shared.lightImpact()
            onTap()
        }) {
            VStack(alignment: .leading, spacing: StarkDesign.Spacing.base) {
                HStack {
                    VStack(alignment: .leading, spacing: StarkDesign.Spacing.tiny) {
                        // Template name with gradient background
                        HStack {
                            Text(template.name)
                                .font(StarkDesign.Typography.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, StarkDesign.Spacing.small)
                                .padding(.vertical, StarkDesign.Spacing.tiny)
                                .background(
                                    RoundedRectangle(cornerRadius: StarkDesign.CornerRadius.small)
                                        .fill(StarkDesign.Gradients.hero)
                                )
                            
                            Spacer()
                        }
                        
                        Text(template.category)
                            .font(StarkDesign.Typography.caption)
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                            .tracking(0.5)
                    }
                    
                    Spacer()
                    
                    Text("\(template.exercises.count)")
                        .font(StarkDesign.Typography.title2)
                        .fontWeight(.bold)
                        .foregroundColor(StarkDesign.Colors.starkBlue)
                        .overlay(
                            Text("exercises")
                                .font(StarkDesign.Typography.mini)
                                .foregroundColor(.secondary)
                                .offset(y: 16)
                        )
                }
                
                // Exercise preview
                VStack(alignment: .leading, spacing: StarkDesign.Spacing.tiny) {
                    let mainExercises = template.exercises.filter { !$0.isWarmup }.prefix(3)
                    ForEach(Array(mainExercises.enumerated()), id: \.offset) { index, exercise in
                        HStack {
                            Circle()
                                .fill(StarkDesign.Colors.starkBlue.opacity(0.2))
                                .frame(width: 4, height: 4)
                            
                            Text(exercise.name)
                                .font(StarkDesign.Typography.mini)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Text("\(exercise.sets) × \(exercise.reps)")
                                .font(StarkDesign.Typography.mini)
                                .foregroundColor(StarkDesign.Colors.starkBlue)
                        }
                    }
                    
                    if template.exercises.filter({ !$0.isWarmup }).count > 3 {
                        HStack {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 4, height: 4)
                            
                            Text("+ \(template.exercises.filter({ !$0.isWarmup }).count - 3) more exercises")
                                .font(StarkDesign.Typography.mini)
                                .foregroundColor(.secondary)
                                .italic()
                        }
                    }
                }
            }
            .padding(StarkDesign.Spacing.base)
        }
        .buttonStyle(PlainButtonStyle())
        .glassCard(opacity: 0.9, cornerRadius: StarkDesign.CornerRadius.large)
        .liquidScale(pressed: isPressed)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
}

// MARK: - AI Suggestion Glass Card

struct AISuggestionCard: View {
    let suggestion: String
    let onAccept: () -> Void
    let onDismiss: () -> Void
    
    @State private var isVisible = false
    
    var body: some View {
        HStack(spacing: StarkDesign.Spacing.base) {
            // AI Icon
            ZStack {
                Circle()
                    .fill(StarkDesign.Gradients.hero)
                    .frame(width: 40, height: 40)
                
                Text("🤖")
                    .font(.system(size: 20))
            }
            
            VStack(alignment: .leading, spacing: StarkDesign.Spacing.tiny) {
                Text("AI Suggestion")
                    .font(StarkDesign.Typography.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(StarkDesign.Colors.starkBlue)
                    .textCase(.uppercase)
                    .tracking(0.5)
                
                Text(suggestion)
                    .font(StarkDesign.Typography.callout)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
            
            VStack(spacing: StarkDesign.Spacing.tiny) {
                Button(action: {
                    HapticManager.shared.success()
                    onAccept()
                }) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28)
                        .background(
                            Circle()
                                .fill(StarkDesign.Colors.successGreen)
                        )
                }
                
                Button(action: {
                    HapticManager.shared.lightImpact()
                    onDismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.secondary)
                        .frame(width: 28, height: 28)
                        .background(
                            Circle()
                                .fill(StarkDesign.Colors.surfaceGlass)
                        )
                }
            }
        }
        .padding(StarkDesign.Spacing.base)
        .background(
            RoundedRectangle(cornerRadius: StarkDesign.CornerRadius.large)
                .fill(StarkDesign.Gradients.hero)
                .overlay(
                    RoundedRectangle(cornerRadius: StarkDesign.CornerRadius.large)
                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                )
        )
        .shadow(color: StarkDesign.Shadow.medium, radius: 8, x: 0, y: 4)
        .scaleEffect(isVisible ? 1.0 : 0.8)
        .opacity(isVisible ? 1.0 : 0.0)
        .offset(y: isVisible ? 0 : 20)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                isVisible = true
            }
        }
    }
}

// MARK: - Stats Glass Card

struct StatsGlassCard: View {
    let title: String
    let value: String
    let subtitle: String
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: StarkDesign.Spacing.base) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(color)
                
                Spacer()
                
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 8, height: 8)
            }
            
            VStack(alignment: .leading, spacing: StarkDesign.Spacing.tiny) {
                Text(value)
                    .font(StarkDesign.Typography.title1)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(title)
                    .font(StarkDesign.Typography.caption)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                    .tracking(0.5)
                
                if !subtitle.isEmpty {
                    Text(subtitle)
                        .font(StarkDesign.Typography.mini)
                        .foregroundColor(color)
                        .fontWeight(.medium)
                }
            }
            
            Spacer()
        }
        .padding(StarkDesign.Spacing.base)
        .frame(height: 120)
        .glassCard()
    }
}