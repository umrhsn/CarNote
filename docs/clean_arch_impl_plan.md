# Clean Architecture Implementation Plan

## Current Analysis

The project already has good separation but needs proper clean architecture layers.

## Implementation Strategy

### 1. Keep Existing Working Code

- Database helper functionality
- Notification services
- UI components and widgets
- Routing and localization
- Form validation

### 2. Create Missing Clean Architecture Components

#### A. Car Feature

```
features/car_info/
├── data/
│   ├── data_sources/
│   │   └── car_local_data_source.dart
│   ├── models/
│   │   └── car_model.dart
│   └── repositories/
│       └── car_repository_impl.dart
├── domain/
│   ├── entities/ (existing car.dart)
│   ├── repositories/
│   │   └── car_repository.dart
│   └── use_cases/
│       ├── save_car_use_case.dart
│       └── get_car_use_case.dart
└── presentation/ (existing)
```

#### B. Consumables Feature

```
features/consumables/
├── data/
│   ├── data_sources/
│   │   └── consumable_local_data_source.dart
│   ├── models/
│   │   └── consumable_model.dart
│   └── repositories/
│       └── consumable_repository_impl.dart
├── domain/
│   ├── entities/ (existing consumable.dart)
│   ├── repositories/
│   │   └── consumable_repository.dart
│   └── use_cases/
│       ├── save_consumables_use_case.dart
│       ├── get_consumables_use_case.dart
│       ├── add_consumable_use_case.dart
│       ├── remove_consumable_use_case.dart
│       ├── reset_consumable_use_case.dart
│       └── reorder_consumables_use_case.dart
└── presentation/ (existing)
```

### 3. Core Services Architecture

```
core/
├── services/
│   ├── database/
│   │   ├── database_service.dart (abstract)
│   │   └── hive_database_service.dart (implementation)
│   ├── file/
│   │   ├── file_service.dart (abstract)
│   │   └── file_service_impl.dart
│   └── notification/
│       ├── notification_service.dart (abstract)
│       └── notification_service_impl.dart
```

### 4. Implementation Steps

1. Create abstract repositories and use cases
2. Create data sources that wrap existing DatabaseHelper functionality
3. Create models that extend entities
4. Implement repository implementations
5. Update cubits to use use cases instead of direct database calls
6. Update dependency injection

### 5. Key Principles

- Keep existing DatabaseHelper functionality as core service
- Use existing entities, extend with models only when needed
- Wrap existing services with clean architecture interfaces
- Maintain all existing UI and business logic
- Use Equatable and Dartz as specified
- Simple, descriptive naming conventions