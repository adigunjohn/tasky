# Tasky

Tasky is a robust, modern Task Management application built with Flutter, designed to help users stay organized with a clean, intuitive interface. It follows clean architecture principles and utilizes industry-standard libraries for state management, local persistence, and secure data handling.

## Features

- **User Authentication**: Secure sign-up and login functionality to keep user data private.
- **Task Management**: Effortlessly create, view, edit, and delete tasks.
- **Task Status Tracking**: Toggle tasks between 'Pending' and 'Completed' statuses.
- **Offline Access**: View your previously synced tasks even without an internet connection, powered by Hive local storage. (Note: Task modification requires an active connection).
- **Secure Token Handling**: Sensitive authentication tokens are stored securely using `flutter_secure_storage`.
- **Responsive UI**: A modern design with custom widgets, theme support, and responsive layouts that look great on any device.
- **Input Validation**: Robust validation for task titles, descriptions, and user credentials to ensure data integrity.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) - For cross-platform UI development.
- **Language**: [Dart](https://dart.dev/) - Optimized for building high-performance apps.
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) - Implements the BLoC (Business Logic Component) pattern for predictable state transitions.
- **Local Database**: [Hive](https://pub.dev/packages/hive) - A lightweight and blazing-fast key-value database for offline data access.
- **Secure Storage**: [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) - For storing sensitive information like JWT tokens.
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) - A simple Service Locator for decoupling components.
- **Networking**: [http](https://pub.dev/packages/http) (or similar) - For API communication.
- **Models & Serialization**: [json_serializable](https://pub.dev/packages/json_serializable) & [equatable](https://pub.dev/packages/equatable) for clean data models and value-based equality.

## Project Structure

The project follows a modular structure to ensure maintainability and scalability:

```text
lib/
├── app/          # Core configuration, routing, and global theme definitions.
├── core/         # The brain of the app: Blocs, Models, Repositories, and Services.
│   ├── blocs/    # Business logic components for Auth and Task management.
│   ├── models/   # Data classes and JSON serialization logic.
│   ├── services/ # External API and storage service implementations.
├── ui/           # UI layer containing screens and reusable custom widgets.
└── utils/        # Shared helpers, extensions, and application constants.
```

## State Management Approach

Tasky uses the **BLoC (Business Logic Component)** pattern. This approach decouples the presentation layer from the business logic, making the code:
- **Predictable**: State changes are driven by explicit events.
- **Testable**: Business logic can be tested independently of the UI.
- **Maintainable**: Clear separation of concerns makes it easier to add new features or debug existing ones.

## Setup Instructions

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Stable channel)
- [Dart SDK](https://dart.dev/get-dart)
- An IDE (Android Studio, VS Code, or IntelliJ)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/adigunjohn/tasky.git
   cd tasky
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate code:**
   Run the following command to generate the necessary JSON serialization and Hive adapter files:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

---
Developed with focus on performance and user experience.
