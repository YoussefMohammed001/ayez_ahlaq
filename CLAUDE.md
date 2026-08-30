# Ayez Ahlaq (عايز أحلق)

Arabic-first, RTL barber booking app. **One Flutter app, one repo, three user types** selected on a user-type screen at startup: `customer`, `barber`, `merchant`.

Product spec: `lib/app_idea_prototype/Ayez_ahlaq/PROJECT_BRIEF.md` (Arabic). The `lib/app_idea_prototype/` folder is a **reference-only prototype** — read its screens/models for UI intent, never import from it, and delete it once its screens are ported.

---

## Non-negotiable rules

1. **Full Clean Architecture** per feature: `data/` → `domain/` → `presentation/`.
2. **SOLID** everywhere. Depend on abstractions (`IXxxRepo`), not implementations.
3. **No duplicated code.** Before writing any widget, search `lib/core/widgets/`, `lib/shared/`, and existing features for one that already does the job. Reuse or extend it — do not create a near-copy.
4. **No comments in code.** Names must carry the meaning.
5. **One class per file.**
6. **Max 150 lines per file.** Split into widgets/helpers when approaching the limit.
7. **Read `lib/core/` before writing anything.** It is a complete production skeleton — reuse it.
8. **Flavors:** `main_dev.dart` and `main_prod.dart`.

---

## Current state

- `lib/core/` and `lib/shared/` are ported from a prior production app and are the foundation.
- `lib/features/` **does not exist yet**.
- `lib/core/di/services_locator.dart` and `lib/core/routes/app_routes.dart` still import ~60 files from that prior app (`trips/`, `fleet/`, `vehicles/`, `sub_drivers/`, `wallet/`). **The project does not compile until these are stripped down to Ayez Ahlaq features.**
- `lib/shared/user_type.dart` holds the prior app's enums; it must be replaced with `customer / barber / merchant`.
- `lib/main.dart` is a stub with a wrong import (`package:shimmer/main.dart`) — replaced by the two flavor entrypoints.
- `lib/app.dart` class is named `ayez_ahlaqApp` — rename to `AyezAhlaqApp`.

---

## Architecture

```
lib/
  main_dev.dart / main_prod.dart   flavor entrypoints → bootstrap → AyezAhlaqApp
  app.dart                         MaterialApp.router, ScreenUtil, theme, l10n, RTL
  core/                            infrastructure — read before writing anything
  shared/                          cross-feature widgets, enums, mappers
  features/<area>/<feature>/
    data/
      apis/            <name>_api.dart          NetworkService calls
      models/          <name>_model.dart        json_serializable DTOs
      repos/           <name>_repo.dart         implements the domain interface
    domain/
      entities/        <name>_entity.dart
      repos/           i_<name>_repo.dart
      use_cases/       <verb>_<noun>_use_case.dart
    presentation/
      manager/         <name>_cubit.dart + <name>_state.dart
      pages/           <name>_screen.dart
      widgets/         feature-local widgets only
```

Data flow: `Screen` → `Cubit` → `UseCase` → `IRepo` → `Repo` → `Api` → `NetworkService`.

Every API call returns `Either<Failure, T>` (`dartz`). Never let a `DioException` escape the data layer.

---

## Core — what already exists (reuse, don't rewrite)

**Networking** — `core/network/`
- `NetworkService` — `getData`, `postData`, `putData`, `deleteData`, `uploadFile`, `patchFile`, `postEncryptedData`, `getImageData`. All return `Either<Failure, dynamic>`, handle offline, and normalize error messages.
- `DioFactory`, `AuthorizationInterceptor`, `ConnectionChecker`, `SignatureGenerator`
- `constants/endpoints.dart` — currently the prior app's endpoints; replace with Ayez Ahlaq's.

**Errors** — `core/error/failure.dart` → `Failure(message, statusCode, data)`

**DI** — `core/di/services_locator.dart`, global `sl`. Register: `Api` and `Repo` as `registerLazySingleton`, `Cubit` as `registerFactory` (except app-lifetime cubits).

**Routing** — `core/routes/`: `route_paths.dart` (`Routes` constants), `app_routes.dart` (GoRouter), `rootNavigatorKey`. Args are passed via `state.extra`.

**Storage** — `core/cache/`: `PreferencesStorage` (+ `PreferencesKeys` enum), `SecureStorage` (+ `SecureStorageKeys`, token lives here).

**Theme** — `core/theme/`: `light_theme.dart`, `dark_theme.dart`, `AppLightColors`, `AppDarkColors`, `AppDimensions`, `Decorations`, and `styles.dart` (`font14w600`, `font20w700`, … — use these, never a raw `TextStyle` with a literal size).
Colors currently belong to the prior app; retheme to the brief: bg `#1C1916`, accent `#C6982F`.

**Core widgets** — `core/widgets/`: `AppText`, `AppButton` (+ `.icon`), `AppFormField`, `AppDropDownFormField`, `AppDateField`, `AdaptiveCheckBox`, `DefaultAppBar`, `AppImage`, `AppSvg`, `AppAsset`, `AppAttachmentRow`, `BounceIt`, `FailureWidget`, `OfflineBanner`, `FullScreenImageViewer`.

**Shared widgets** — `lib/shared/`: `SuccessScreen`, `ResendButton`, `OrWidget`, `SwitchRowWidget`, `TimePickerButton`, `ConfirmCancelDialog`, `PasswordFormField`, `ConfirmPasswordFormField`, `ApprovalGuard`, `FirstRunEmptyState`, `HaveAccountOrNotRow`.

**Other core** — `app_cubit/` (theme + connectivity), `session/SessionManager` (unauthorized stream), `crash_reporting/` (Crashlytics + Sentry behind `VSOCrashReportingManager`), `notifications/`, `security/`, `app_startup/` (version check, force update, remote config), `helpers/` (`Alerts`, `Validators`, `PhoneNumberValidators`, `AppDateTime`, `AppImagePicker`, `safePrint`, `NumberConvertor`, `ScreenPadding`), `extensions/` (`ext.dart` → `10.hSpace`, `.toColor()`; `ext_theme.dart` → `context.theme`, `context.colorScheme`).

---

## Conventions

- **State**: `flutter_bloc` Cubits only. One `Cubit` + one `State` (Equatable) per file.
- **Sizing**: `flutter_screenutil` — `.w .h .sp .r`. Design size `402 × 874`. Never hardcode pixels.
- **Text**: `AppText` with a style from `core/theme/styles.dart`.
- **Strings**: `lib/l10n/*.arb` → `S().key`. No hardcoded user-facing strings.
- **Navigation**: `go_router` via `Routes` constants. No `Navigator.push` with inline widgets.
- **Models**: `json_serializable` + `build_runner`.
- **Naming**: files `snake_case`, classes `PascalCase`, interfaces `IXxxRepo`, use cases `VerbNounUseCase`.
- **Logging**: `safePrint`, never `print`.

## Flavors

`lib/env/flavor.dart` (`Flavor.dev` / `Flavor.prod`, `currentFlavor`) and `lib/env/env.dart` (`isDevEnvironment()`). Each entrypoint sets `currentFlavor` before `ServicesLocator().init()`. Dev enables Chucker and verbose Dio logging; prod does not. Android/iOS flavor configs are not set up yet.

## Commands

```bash
flutter run --flavor dev -t lib/main_dev.dart
flutter run --flavor prod -t lib/main_prod.dart
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter analyze
```

## Never

- Import from `lib/app_idea_prototype/`.
- Add `provider` or `google_fonts` (the brief predates this architecture — Cubit and the bundled font system win).
- Put business logic in a widget.
- Call `NetworkService` from a Cubit or a screen.
- Write a widget without first checking `core/widgets/` and `shared/`.
