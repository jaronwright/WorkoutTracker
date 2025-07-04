//
//  StarkDesignSystem.swift
//  Workout Tracker
//
//  Created by Jaron Wright on 7/3/25.
//

import SwiftUI

// MARK: - Color System
struct StarkColors {
    // Primary Palette
    static let starkBlue = Color(red: 0/255, green: 122/255, blue: 255/255)
    static let starkBlueLight = Color(red: 77/255, green: 163/255, blue: 255/255)
    static let starkBlueDark = Color(red: 0/255, green: 81/255, blue: 213/255)
    
    static let powerOrange = Color(red: 255/255, green: 107/255, blue: 53/255)
    static let powerOrangeLight = Color(red: 255/255, green: 143/255, blue: 102/255)
    static let powerOrangeDark = Color(red: 229/255, green: 73/255, blue: 32/255)
    
    // Glass Layers
    static let surfaceGlass = Color.white.opacity(0.7)
    static let elevatedGlass = Color.white.opacity(0.85)
    static let surfaceGlassDark = Color(red: 28/255, green: 28/255, blue: 30/255).opacity(0.8)
    static let elevatedGlassDark = Color(red: 44/255, green: 44/255, blue: 46/255).opacity(0.9)
    
    // Semantic Colors
    static let successGreen = Color(red: 52/255, green: 199/255, blue: 89/255)
    static let warningAmber = Color(red: 255/255, green: 149/255, blue: 0/255)
    static let errorRed = Color(red: 255/255, green: 59/255, blue: 48/255)
    static let restBlue = Color(red: 90/255, green: 200/255, blue: 250/255)
    
    // Gradients
    static let heroGradient = LinearGradient(
        colors: [
            starkBlue.opacity(0.2),
            powerOrange.opacity(0.2)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let elevationGradient = LinearGradient(
        colors: [
            Color.white.opacity(0.9),
            Color.white.opacity(0.7)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}

// MARK: - Typography
struct StarkTypography {
    static let hero = Font.system(size: 34, weight: .bold, design: .default)
    static let title1 = Font.system(size: 28, weight: .semibold, design: .default)
    static let title2 = Font.system(size: 22, weight: .semibold, design: .default)
    static let title3 = Font.system(size: 20, weight: .medium, design: .default)
    static let body = Font.system(size: 17, weight: .regular, design: .default)
    static let callout = Font.system(size: 16, weight: .medium, design: .default)
    static let subhead = Font.system(size: 15, weight: .regular, design: .default)
    static let caption = Font.system(size: 13, weight: .regular, design: .default)
    static let mini = Font.system(size: 11, weight: .medium, design: .default)
}

// MARK: - Spacing
struct StarkSpacing {
    static let micro: CGFloat = 4
    static let tiny: CGFloat = 8
    static let small: CGFloat = 12
    static let base: CGFloat = 16
    static let medium: CGFloat = 24
    static let large: CGFloat = 32
    static let xl: CGFloat = 48
    static let xxl: CGFloat = 64
}

// MARK: - Glass Card Modifier
struct GlassCardModifier: ViewModifier {
    let cornerRadius: CGFloat
    let blurRadius: CGFloat
    let opacity: Double
    
    init(cornerRadius: CGFloat = 16, blurRadius: CGFloat = 20, opacity: Double = 0.8) {
        self.cornerRadius = cornerRadius
        self.blurRadius = blurRadius
        self.opacity = opacity
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(StarkColors.elevatedGlass)
                    .opacity(opacity)
            )
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 4)
    }
}

// MARK: - Primary Button Style
struct StarkPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(StarkTypography.callout)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(StarkColors.starkBlue)
                    .opacity(configuration.isPressed ? 0.8 : 1.0)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

// MARK: - Glass Input Field Style
struct GlassInputFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(StarkSpacing.base)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(StarkColors.surfaceGlass)
                    .opacity(0.7)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
}

// MARK: - Workout Card Component
struct WorkoutCard: View {
    let workout: WorkoutSession
    let progress: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: StarkSpacing.small) {
            HStack {
                VStack(alignment: .leading, spacing: StarkSpacing.tiny) {
                    Text(workout.name)
                        .font(StarkTypography.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text("\(workout.sets) × \(workout.reps) • \(workout.weight) lbs")
                        .font(StarkTypography.callout)
                        .foregroundColor(StarkColors.starkBlue)
                }
                
                Spacer()
                
                // Progress Ring
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 3)
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(StarkColors.starkBlue, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 0.5), value: progress)
                }
                .frame(width: 40, height: 40)
            }
            
            if !workout.notes.isEmpty {
                Text(workout.notes)
                    .font(StarkTypography.caption)
                    .foregroundColor(.secondary)
                    .italic()
            }
        }
        .padding(StarkSpacing.base)
        .modifier(GlassCardModifier())
    }
}

// MARK: - AI Suggestion Card
struct AISuggestionCard: View {
    let message: String
    let onAccept: () -> Void
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: StarkSpacing.base) {
            HStack {
                Image(systemName: "brain.head.profile")
                    .foregroundColor(StarkColors.starkBlue)
                Text("AI Suggestion")
                    .font(StarkTypography.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            Divider()
                .background(Color.white.opacity(0.3))
            
            Text(message)
                .font(StarkTypography.body)
                .foregroundColor(.primary)
            
            HStack(spacing: StarkSpacing.small) {
                Button("Accept") {
                    onAccept()
                }
                .buttonStyle(StarkPrimaryButtonStyle())
                
                Button("Dismiss") {
                    onDismiss()
                }
                .font(StarkTypography.callout)
                .foregroundColor(.secondary)
                .padding(StarkSpacing.base)
            }
        }
        .padding(StarkSpacing.base)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(StarkColors.heroGradient)
                .opacity(0.9)
        )
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Exercise Logger Component
struct ExerciseLogger: View {
    @Binding var sets: [ExerciseSet]
    
    var body: some View {
        VStack(spacing: StarkSpacing.small) {
            HStack {
                Text("Reps")
                    .font(StarkTypography.caption)
                    .fontWeight(.medium)
                Spacer()
                Text("Weight")
                    .font(StarkTypography.caption)
                    .fontWeight(.medium)
                Spacer()
                Text("Status")
                    .font(StarkTypography.caption)
                    .fontWeight(.medium)
            }
            .foregroundColor(.secondary)
            .padding(.horizontal, StarkSpacing.base)
            
            ForEach($sets) { $set in
                SetRow(set: $set)
            }
        }
        .modifier(GlassCardModifier())
    }
}

struct SetRow: View {
    @Binding var set: ExerciseSet
    
    var body: some View {
        HStack(spacing: StarkSpacing.small) {
            TextField("", value: $set.reps, format: .number)
                .textFieldStyle(GlassInputFieldStyle())
                .keyboardType(.numberPad)
            
            TextField("", value: $set.weight, format: .number)
                .textFieldStyle(GlassInputFieldStyle())
                .keyboardType(.decimalPad)
            
            Button(action: {
                set.isCompleted.toggle()
            }) {
                Image(systemName: set.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(set.isCompleted ? StarkColors.successGreen : .secondary)
                    .font(.title2)
            }
        }
        .padding(.horizontal, StarkSpacing.base)
    }
}

// MARK: - Exercise Set Model
struct ExerciseSet: Identifiable {
    let id = UUID()
    var reps: Int = 0
    var weight: Double = 0
    var isCompleted: Bool = false
}

// MARK: - Extensions
extension View {
    func glassCard(cornerRadius: CGFloat = 16, blurRadius: CGFloat = 20, opacity: Double = 0.8) -> some View {
        self.modifier(GlassCardModifier(cornerRadius: cornerRadius, blurRadius: blurRadius, opacity: opacity))
    }
    
    func starkPrimaryButton() -> some View {
        self.buttonStyle(StarkPrimaryButtonStyle())
    }
    
    func glassInputField() -> some View {
        self.textFieldStyle(GlassInputFieldStyle())
    }
}