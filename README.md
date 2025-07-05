# Car Note

![feature_graphic_en](https://github.com/umrhsn/CarNote/assets/55505500/bad4f3ed-71b4-4c6b-b15e-9de8b96a27d7)
> A special app for your car made with [Flutter](https://flutter.dev/) following Clean Architecture
> principles.
> Live demo [
_here_](https://drive.google.com/file/d/19giAcufBPk1uVwB0XPbEUAxo8IJM5PfE/view?usp=sharing).

## Table of Contents

* [General Info](#general-information)
* [Architecture](#architecture)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Screenshots](#screenshots)
* [Dependencies](#dependencies)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)
* [Acknowledgements](#acknowledgements)
* [Contact](#contact)

## General Information

Have you ever struggled with remembering when you have to replace / change items in your car, like
engine oil, timing belt, etc...?
Have you ever wondered what your dashboard lights mean and what to do when they appear?
This app is designed just for you to make your life easier.

## Architecture

This project follows **Clean Architecture** principles with proper separation of concerns:

### 🏗️ **Layer Structure**

```
├── 📊 Presentation Layer (UI + State Management)
│   ├── Pages (Screens)
│   ├── Widgets (Reusable UI Components)
│   └── Cubits (BLoC State Management)
│
├── 🔄 Domain Layer (Business Logic)
│   ├── Entities (Pure Business Objects)
│   ├── Repositories (Interfaces)
│   └── Use Cases (Business Rules)
│
└── 💾 Data Layer (External Concerns)
    ├── Models (Data Transfer Objects)
    ├── Data Sources (Local/Remote)
    └── Repository Implementations
```

### 🎯 **Key Benefits**

- **Testability**: Each layer can be tested in isolation
- **Maintainability**: Clear separation of concerns
- **Scalability**: Easy to add new features and data sources
- **Independence**: Business logic is independent of frameworks

### 🔧 **Design Patterns Used**

- **Repository Pattern**: Abstracts data access
- **Dependency Injection**: Loose coupling between components
- **BLoC Pattern**: Reactive state management
- **Adapter Pattern**: Data model ↔ Entity conversion

## Technologies Used

- **Architecture**: Clean Architecture with SOLID principles
- **State Management**: BLoC (Cubit) pattern
- **Dependency Injection**: GetIt service locator
- **Local Database**: Hive with proper data models
- **Code Generation**: build_runner for Hive adapters
- **Testing**: Unit tests for each layer
- **Internationalization**: Custom localization system

## Features

- 🚗 **Car Management**: Add and manage your car data
- 📊 **Consumables Tracking**: Monitor maintenance items and intervals
- 🔔 **Smart Notifications**: Get reminders for upcoming maintenance
- 📱 **Dashboard Lights Guide**: Learn about warning symbols
- 🌍 **Multi-language Support**: Arabic and English
- 📤 **Data Export**: Save your data to files
- 🎨 **Modern UI**: Clean, intuitive interface with animations

## Screenshots

![screenshots_github](https://github.com/umrhsn/CarNote/assets/55505500/5ab13079-1b3a-40e1-a232-eed88e7732c4)

## Dependencies

### Core Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6

  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5

  # Dependency Injection
  get_it: ^7.6.4

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  path_provider: ^2.1.1
  shared_preferences: ^2.2.2

  # Functional Programming
  dartz: ^0.10.1

  # UI & Animations
  flutter_staggered_animations: ^1.1.1
  flutter_screenutil: ^5.9.0
  smooth_page_indicator: ^1.1.0
  tutorial_coach_mark: ^1.2.11
  bot_toast: ^4.1.3

  # Notifications
  awesome_notifications: ^0.8.2
  cron: ^0.5.1

  # File Operations
  file_saver: ^0.2.8

  # Utilities
  material_design_icons_flutter: ^7.0.7296
  provider: ^6.0.5
  intl: ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

  # Code Generation
  build_runner: ^2.4.7
  hive_generator: ^2.0.1
  json_serializable: ^6.7.1
  json_annotation: ^4.8.1

  # Testing
  mockito: ^5.4.2
  bloc_test: ^9.1.4
```

## Project Status

Project is: _actively maintained_ with clean architecture implementation.

### ✅ **Recently Completed**

- Implemented proper Clean Architecture structure
- Separated data models from domain entities
- Added comprehensive dependency injection
- Created testable repository pattern
- Implemented proper error handling with Either types

### 🚧 **Current Focus**

- Comprehensive unit testing suite
- Integration tests for critical flows
- API integration preparation
- Performance optimizations

## Room for Improvement

### 🔧 **Technical Improvements**

- [ ] **Testing Coverage**: Achieve 90%+ test coverage across all layers
- [ ] **Performance**: Implement lazy loading and caching strategies
- [ ] **Offline Support**: Enhanced offline-first capabilities
- [ ] **API Integration**: Add cloud synchronization support
- [ ] **CI/CD**: Automated testing and deployment pipeline

### 🎨 **Feature Enhancements**

- [ ] **Multiple Cars**: Support for managing multiple vehicles
- [ ] **Service History**: Track maintenance history and costs
- [ ] **Reminders**: Smart notification system with customizable alerts
- [ ] **Analytics**: Usage patterns and maintenance insights
- [ ] **Backup/Restore**: Cloud backup and data migration tools

### 🌟 **Future Roadmap**

- [ ] **Web Platform**: Progressive Web App version
- [ ] **Desktop Support**: Windows/macOS applications
- [ ] **Social Features**: Share maintenance tips and experiences
- [ ] **AI Integration**: Predictive maintenance recommendations

## Development Setup

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK
- Android Studio / VS Code

### Getting Started

```bash
# Clone the repository
git clone https://github.com/umrhsn/CarNote.git

# Navigate to project directory
cd CarNote

# Get dependencies
flutter pub get

# Generate code (Hive adapters)
dart run build_runner build

# Run the app
flutter run
```

### Architecture Guidelines

1. **Domain entities** should be pure Dart objects with no external dependencies
2. **Data models** handle serialization and persistence concerns
3. **Use cases** contain single-responsibility business logic
4. **Repositories** provide clean interfaces for data access
5. **Cubits** manage UI state and coordinate between layers

## Testing Strategy

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

## Acknowledgements

- This project was inspired by my
  friend [Ahmed Yehia](https://www.linkedin.com/in/ahmed-yehia-63b2661a5/), a certified SAP
  Consultant
- Clean Architecture implementation based
  on tutorial: [Clean Architecture in Flutter (Arabic)](https://www.udemy.com/course/clean-architecture-in-flutter-arabic)

## Contact

Created by [Umar Hasan](https://www.linkedin.com/in/umrhsn/) - feel free to contact me!

### 📧 **Professional Inquiries**

- LinkedIn: [Umar Hasan](https://www.linkedin.com/in/umrhsn/)
- Email: [Contact through GitHub](https://github.com/umrhsn)

### 🤝 **Contributing**

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open
an issue first to discuss what you would like to change.