# Workout Tracker

A SwiftUI-based iOS application for tracking your workouts and exercise routines.

## Features

- **Add Workouts**: Enter exercise details including name, sets, reps, weight, and notes
- **Workout List**: View all your workouts in a clean, organized list
- **Delete Workouts**: Swipe to delete workouts you no longer need
- **SwiftData Integration**: Persistent storage using SwiftData
- **Modern UI**: Clean, intuitive interface following iOS design guidelines

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository
2. Open `Workout Tracker.xcodeproj` in Xcode
3. Build and run the project on your device or simulator

## Usage

1. Enter your exercise name in the "Exercise Name" field
2. Fill in the number of sets, reps, and weight (optional)
3. Add any notes if needed
4. Tap "Add Workout" to save your workout
5. View your workouts in the list below
6. Swipe left on any workout to delete it

## Development

This project uses SwiftData for persistent storage and follows modern SwiftUI patterns. The main components are:

- `ContentView.swift`: Main interface with workout input and list
- `WorkoutSessionView.swift`: Additional workout session functionality
- SwiftData model for workout persistence

## License

This project is open source and available under the MIT License. 