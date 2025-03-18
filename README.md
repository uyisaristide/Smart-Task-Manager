<<<<<<< HEAD
# Task Manager - Flutter Practical Exam

## Overview
This Flutter application is a **Task Manager**, built as part of a practical exam for a software developer role. The app allows users to manage tasks efficiently with features like authentication, real-time synchronization, offline support, push notifications, and advanced state management.

## Features Implemented

### ✅ Task Management
- Display a list of tasks with **title, description, priority, due date, and status**.
- Add, edit, delete, and mark tasks as **completed**.
- Implemented **search and filter** system (by priority, status, and due date).

### ✅ User Authentication
- Integrated **Firebase Authentication** with Google Sign-In and Email/Password login.
- Ensured API calls are secured using Firebase Authentication tokens.

### ✅ Real-time Database
- Tasks are stored in **Firebase Firestore**, allowing real-time data synchronization.
- Implemented **offline mode**: Tasks remain accessible without an internet connection and sync automatically when back online.

### ✅ Push Notifications & Reminders
- Used **flutter_local_notifications** for task reminders.
- Implemented **background scheduling** using `workmanager` for persistent notifications.

### ✅ State Management & Architecture
- Used **Riverpod** with **Notifiers and Providers** for state management.
- Followed **Clean Architecture** principles with a modular structure:
  - **routes/** → App navigation using **GoRouter**.
  - **providers/** → State management using **Riverpod**.
  - **models/** → Data models for tasks.
  - **Views/** → UI components and screens.
  - **constants/** → Global constants and theme configurations.

### ✅ Theming & Dark Mode
- Implemented **light & dark mode switching**.
- Allowed users to customize primary theme colors dynamically.

### ✅ CI/CD & Testing
- Added **unit tests** for business logic and **widget tests** for UI verification.
- Configured **GitHub Actions** for automated testing and CI/CD pipeline.

## Project Structure
```
lib/
├── main.dart
├── router/        # Application routes (GoRouter)
├── providers/     # Riverpod providers & state management
├── models/        # Data models for tasks
├── Views/         # UI screens and components
├── constants/     # Theme, colors, and app-wide constants
├── services/      # Firebase & local storage services
└── utils/         # Helper functions & utilities
```

## Tools & Libraries Used
- **State Management**: Riverpod (Notifiers & Providers)
- **Routing**: GoRouter
- **Database**: Firebase Firestore (with offline persistence)
- **Auth & Security**: Firebase Authentication, Google Sign-In
- **Background Tasks**: Workmanager
- **Notifications**: flutter_local_notifications, Firebase Cloud Messaging
- **Location Services**: geolocator, geofencing
- **QR Code Scanning**: qr_code_scanner, qr_flutter

## Setup Instructions
1. **Clone the repository:**
   ```sh
   git clone <repository-url>
   cd task_manager
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Set up Firebase:**
   - Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
   - Enable Firestore, Authentication, and Cloud Messaging in Firebase Console.
4. **Run the app:**
   ```sh
   flutter run
   ```

## Screenshots & Demonstration
*(Include relevant screenshots or GIFs showing app functionality)*

## Conclusion
This project follows best practices in Flutter development, incorporating clean architecture, efficient state management, and seamless user experience. It is optimized for both **Android, iOS, Web, and Desktop platforms**.

---

🚀 **Developed by Aristide Uyisenga**
