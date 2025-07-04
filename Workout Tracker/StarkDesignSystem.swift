//
//  StarkDesignSystem.swift
//  Workout Tracker
//
//  Created by Jaron Wright on 7/3/25.
//

import SwiftUI

// MARK: - Stark Design System

struct StarkDesign {
    
    // MARK: - Colors
    struct Colors {
        // Hero Colors
        static let starkBlue = Color(red: 0, green: 0.48, blue: 1.0) // #007AFF
        static let starkBlueLight = Color(red: 0.3, green: 0.64, blue: 1.0) // #4DA3FF
        static let starkBlueDark = Color(red: 0, green: 0.32, blue: 0.84) // #0051D5
        
        static let powerOrange = Color(red: 1.0, green: 0.42, blue: 0.21) // #FF6B35
        static let powerOrangeLight = Color(red: 1.0, green: 0.56, blue: 0.4) // #FF8F66
        static let powerOrangeDark = Color(red: 0.9, green: 0.29, blue: 0.13) // #E54920
        
        // Semantic Colors
        static let successGreen = Color(red: 0.2, green: 0.78, blue: 0.35) // #34C759
        static let warningAmber = Color(red: 1.0, green: 0.58, blue: 0) // #FF9500
        static let errorRed = Color(red: 1.0, green: 0.23, blue: 0.19) // #FF3B30
        static let restBlue = Color(red: 0.35, green: 0.78, blue: 0.98) // #5AC8FA
        
        // Glass Surfaces
        static let surfaceGlassLight = Color.white.opacity(0.7)
        static let surfaceGlassDark = Color(red: 0.11, green: 0.11, blue: 0.12).opacity(0.8)
        static let elevatedGlassLight = Color.white.opacity(0.85)
        static let elevatedGlassDark = Color(red: 0.17, green: 0.17, blue: 0.18).opacity(0.9)
        
        // Dynamic Glass
        static var surfaceGlass: Color {
            Color(UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? 
                UIColor(surfaceGlassDark) : UIColor(surfaceGlassLight)
            })
        }
        
        static var elevatedGlass: Color {
            Color(UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? 
                UIColor(elevatedGlassDark) : UIColor(elevatedGlassLight)
            })
        }
    }
    
    // MARK: - Typography
    struct Typography {
        // SF Pro Display - Headers
        static let hero = Font.system(size: 34, weight: .bold, design: .default)
        static let title1 = Font.system(size: 28, weight: .semibold, design: .default)
        static let title2 = Font.system(size: 22, weight: .semibold, design: .default)
        static let title3 = Font.system(size: 20, weight: .medium, design: .default)
        
        // SF Pro Text - Body
        static let body = Font.system(size: 17, weight: .regular, design: .default)
        static let callout = Font.system(size: 16, weight: .medium, design: .default)
        static let subhead = Font.system(size: 15, weight: .regular, design: .default)
        static let caption = Font.system(size: 13, weight: .regular, design: .default)
        static let mini = Font.system(size: 11, weight: .medium, design: .default)
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let micro: CGFloat = 4
        static let tiny: CGFloat = 8
        static let small: CGFloat = 12
        static let base: CGFloat = 16
        static let medium: CGFloat = 24
        static let large: CGFloat = 32
        static let xl: CGFloat = 48
        static let xxl: CGFloat = 64
    }
    
    // MARK: - Corner Radius
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xl: CGFloat = 20
        static let pill: CGFloat = 25
    }
    
    // MARK: - Shadows
    struct Shadow {
        static let light = Color.black.opacity(0.04)
        static let medium = Color.black.opacity(0.08)
        static let heavy = Color.black.opacity(0.12)
    }
    
    // MARK: - Gradients
    struct Gradients {
        static let hero = LinearGradient(
            colors: [
                Colors.starkBlue.opacity(0.2),
                Colors.powerOrange.opacity(0.2)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let elevation = LinearGradient(
            colors: [
                Colors.elevatedGlass,
                Colors.surfaceGlass
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let success = LinearGradient(
            colors: [
                Colors.successGreen.opacity(0.8),
                Colors.successGreen.opacity(0.4)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Glass Effect Modifier

struct GlassEffect: ViewModifier {
    let opacity: Double
    let blur: CGFloat
    let cornerRadius: CGFloat
    
    init(opacity: Double = 0.8, blur: CGFloat = 20, cornerRadius: CGFloat = 16) {
        self.opacity = opacity
        self.blur = blur
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .opacity(opacity)
            )
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .shadow(color: StarkDesign.Shadow.medium, radius: 6, x: 0, y: 4)
    }
}

// MARK: - Animated Glass Card

struct AnimatedGlassCard<Content: View>: View {
    let content: Content
    @State private var isPressed = false
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .modifier(GlassEffect())
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPressed)
            .onTapGesture {
                withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        isPressed = false
                    }
                }
            }
    }
}

// MARK: - Liquid Button

struct LiquidButton: View {
    let title: String
    let action: () -> Void
    let color: Color
    let isLoading: Bool
    
    @State private var isPressed = false
    
    init(_ title: String, color: Color = StarkDesign.Colors.starkBlue, isLoading: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.color = color
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: StarkDesign.Spacing.small) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Text(title)
                        .font(StarkDesign.Typography.callout)
                        .fontWeight(.semibold)
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: StarkDesign.CornerRadius.pill)
                    .fill(color)
                    .opacity(isPressed ? 0.8 : 1.0)
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
}

// MARK: - Glass Tab View

struct GlassTabView: View {
    @Binding var selectedTab: Int
    let tabs: [(icon: String, title: String)]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        selectedTab = index
                    }
                }) {
                    VStack(spacing: StarkDesign.Spacing.tiny) {
                        Image(systemName: tabs[index].icon)
                            .font(.system(size: 24, weight: selectedTab == index ? .semibold : .regular))
                            .foregroundColor(selectedTab == index ? StarkDesign.Colors.starkBlue : .secondary)
                        
                        if selectedTab == index {
                            Text(tabs[index].title)
                                .font(StarkDesign.Typography.mini)
                                .foregroundColor(StarkDesign.Colors.starkBlue)
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, StarkDesign.Spacing.base)
        .padding(.bottom, StarkDesign.Spacing.small)
        .background(.ultraThinMaterial)
    }
}

// MARK: - Progress Ring

struct ProgressRing: View {
    let progress: Double
    let color: Color
    let lineWidth: CGFloat
    
    init(progress: Double, color: Color = StarkDesign.Colors.starkBlue, lineWidth: CGFloat = 6) {
        self.progress = progress
        self.color = color
        self.lineWidth = lineWidth
    }
    
    var body: some View {
        Circle()
            .stroke(color.opacity(0.2), lineWidth: lineWidth)
            .overlay(
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        color,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(response: 0.8, dampingFraction: 0.8), value: progress)
            )
    }
}

// MARK: - Haptic Feedback Manager

class HapticManager {
    static let shared = HapticManager()
    private init() {}
    
    func lightImpact() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
    
    func mediumImpact() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    func heavyImpact() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.impactOccurred()
    }
    
    func success() {
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.success)
    }
    
    func error() {
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.error)
    }
    
    func selection() {
        let selectionFeedback = UISelectionFeedbackGenerator()
        selectionFeedback.selectionChanged()
    }
}

// MARK: - View Extensions

extension View {
    func glassCard(opacity: Double = 0.8, blur: CGFloat = 20, cornerRadius: CGFloat = 16) -> some View {
        modifier(GlassEffect(opacity: opacity, blur: blur, cornerRadius: cornerRadius))
    }
    
    func liquidScale(pressed: Bool) -> some View {
        scaleEffect(pressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: pressed)
    }
    
    func onTapWithHaptic(perform action: @escaping () -> Void) -> some View {
        onTapGesture {
            HapticManager.shared.lightImpact()
            action()
        }
    }
}