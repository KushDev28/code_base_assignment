# 📱 Codebase Assignment - User Listing App

A Flutter app that fetches a paginated list of users from the ReqRes API, supports infinite scroll, search, offline cache using SharedPreferences, and follows Clean Architecture principles.

---

## 🚀 Features

- ✅ List users with name, email, and avatar
- 🔍 Search users by full name
- 🔁 Pull-to-refresh
- 📦 Pagination (infinite scroll)
- 💾 Offline caching (SharedPreferences)
- 🧱 Clean Architecture (Presentation → Domain → Data)
- 🧪 Riverpod State Management
- 🌐 API integration using Dio
- ✨ Shimmer loading effect
- ❌ Graceful error handling

---

## 📁 Project Structure

lib/
├── core/                          # Core app-level utilities and services
│   ├── connectivity_notifier/     # Notifier for internet connectivity
│   ├── constants/                 # App constants (colors, API paths, etc.)
│   ├── di/                        # Dependency injection setup (e.g. getIt)
│   ├── error/                     # Error handling and API failure models
│   ├── network/                   # Network-related logic (ApiFacade, Dio setup)
│   ├── service/                   # Shared app services (SharedPreferences, etc.)
│   └── utils/                     # General utility functions/helpers

├── feature/                       # Feature-based module
│   └── user_list/                 # User List feature
│       ├── data/                  # Data layer
│       │   ├── api/              # API service classes (e.g. Dio, endpoints)
│       │   ├── mapper/           # DTO ↔ Entity mapper extensions
│       │   ├── models/           # DTOs (Data Transfer Objects)
│       │   ├── repositories/     # Concrete implementations of repositories
│       │   └── source/           # Remote & local data sources

│       ├── domain/               # Domain layer
│       │   ├── entities/         # Business models (e.g., UserEntity)
│       │   ├── mapper/           # Domain-specific mappers (optional)
│       │   ├── repositories/     # Abstract repository interfaces
│       │   └── use_cases/        # Business logic and use case classes

│       ├── presentation/         # Presentation layer
│       │   ├── notifier/         # State management logic (Riverpod, etc.)
│       │   ├── pages/            # UI screens (e.g., UserListScreen)
│       │   └── widgets/          # Reusable UI widgets (e.g., AppBars, Cards)

├── main.dart                     # Application entry point




---

## 🧠 Clean Architecture Layers

1. **Presentation Layer**
    - `UserNotifier` (Riverpod)
    - `UserListScreen`, `UserDetailScreen`
    - Shimmer placeholders

2. **Domain Layer**
    - `UserEntity`
    - `UserRepository`, `UserUseCase`

3. **Data Layer**
    - `UserDto`, `UserResponseDto`
    - `UserRemoteDataSource`, `UserRepositoryImpl`
    - SharedPreferences cache logic

---

## 🧪 State Management

Powered by [Riverpod](https://riverpod.dev/) with `@riverpod` annotation for `UserNotifier`.

---

## 🔗 API

Data is fetched from [ReqRes API](https://reqres.in):

## 📷 Screenshots

| Users List                                        | User Detail                        
|---------------------------------------------------|--------------------------------------------------|
| ![Users](screenshots/user_list_screen.png)      | ![Detail](screenshots/user_detail_screen.png)  | 
# code_base_assignment
