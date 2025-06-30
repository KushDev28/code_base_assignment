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

core/

connectivity_notifier/ – Notifier for internet connectivity state

constants/ – App-wide constants (e.g. colors, API URLs)

di/ – Dependency injection setup (e.g. getIt)

error/ – Error models and handling

network/ – Network layer (API facade, interceptors, config)

service/ – Common/shared services (e.g. SharedPreferences)

utils/ – Helper functions and utilities

feature/

user_list/

data/

api/ – API service classes (Dio, endpoints)

mapper/ – Mappers from DTO to entity

models/ – DTOs (Data Transfer Objects)

repositories/ – Concrete repository implementations

source/ – Data sources (remote/local)

domain/

entities/ – Business/domain models (e.g., UserEntity)

mapper/ – Domain-level mappers (if needed)

repositories/ – Abstract repository interfaces

use_cases/ – Business logic and use cases

presentation/

notifier/ – Riverpod/Notifier classes

pages/ – UI screens/pages

widgets/ – Reusable UI components (ListTile, AppBar, etc.)

main.dart – Application entry point




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
