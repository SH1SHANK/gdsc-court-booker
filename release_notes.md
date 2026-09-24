# Court Booker v1.0.0

A lightweight campus sports court booking system built with Flutter and Dart for the Google Developer Student Clubs (GDSC) App Dev Workshop 2026.

## Downloads & Binary Distribution

Pre-compiled production Android binaries for release `v1.0.0` are available for direct installation:

| Architecture | Package Size | Target Devices | Direct Download | SHA-256 Checksum |
| :--- | :--- | :--- | :--- | :--- |
| **Universal** | 47.1 MB | All supported Android devices (FAT binary) | [app-universal-release.apk](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-universal-release.apk) | `4d4fe54e8b47f8a5f21f8c1a84abee4fb703539d5cb8499145884836a2c0265e` |
| **ARM64 (64-bit)** | 16.4 MB | Modern Android smartphones and tablets (`arm64-v8a`) | [app-arm64-v8a-release.apk](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-arm64-v8a-release.apk) | `92f6a8e6efd460cb62e42f3d74d0400f5a5e4e544ded0b01f6cdc2081d18d15b` |
| **ARMv7 (32-bit)** | 13.9 MB | Older 32-bit Android hardware (`armeabi-v7a`) | [app-armeabi-v7a-release.apk](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-armeabi-v7a-release.apk) | `8a73ed124a341aba967ec404a90e42c631f9700885eba31dfa9587487f9f6023` |
| **x86_64** | 17.8 MB | Android Emulators, ChromeOS, and x86 devices (`x86_64`) | [app-x86_64-release.apk](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-x86_64-release.apk) | `2e5bcd21b1e56f6090108dc37fbece420c5531b751c6aa7ac364e2a603f502b1` |

---

## Executive Summary & Highlights

Court Booker is an athletic facility reservation system engineered for college campuses. It demonstrates production-grade Flutter architecture without external state management dependencies:

- **Facility Discovery**: Campus facilities (Badminton, Basketball, Tennis, Squash) with amenities, locations, and live slot counters.
- **Interactive Date Picker**: Native Material 3 `showDatePicker` scoped to today through 30 days ahead.
- **Accessible Time Slot Selection**: Choice chips with dual visual confirmation (high-contrast athletic green fill + `Icons.check_circle_rounded` icon) for colorblind accessibility.
- **Modal Confirmation Dialog**: Verification dialog displaying venue, date, and chosen time slot before finalizing the reservation.
- **My Bookings Dashboard**: Manage active reservations with court names, sport badges, formatted timestamps, and green "Confirmed" status chips.
- **Safe Cancellation Safeguard**: Confirmation dialog prevents accidental booking deletion, with instant feedback via floating SnackBars.
- **Polished Empty State**: 1-tap "Browse Courts" navigation when no bookings are active.
- **Dynamic Badge Counter**: Live reservation count displayed directly in the AppBar actions.

---

## System Architecture & State Machine

- **Domain-Driven Layered Structure**: Separation of presentation widgets (`CourtCard`, `BookingCard`), screens (`HomeScreen`, `CourtDetailsScreen`, `BookingsScreen`), domain entities (`Court`, `Booking`), and data layer (`sample_data.dart`).
- **Unidirectional Data Flow**: Pure downward propagation via typed constructors; upward notifications handled via route returns and `setState()` rebuilds.
- **Zero Third-Party Dependencies**: Pure Flutter SDK and Dart standard library.
- **Material 3 Athletic Theme**: Seed color `#1E6F5C` with surface elevation and high-contrast typography.

---

## Verification & Quality Assurance

- **Static Analysis**: `flutter analyze` completed with **0 issues found** (0 errors, 0 warnings, 0 lints).
- **Automated Test Matrix**: 4 passing widget and accessibility tests in `test/widget_test.dart` validating facility feed rendering, end-to-end booking flow, cancellation safeguards, empty states, and accessibility guidelines (`androidTapTargetGuideline` and `labeledTapTargetGuideline`).
- **Live Device Verification**: Fully verified end-to-end on Android Emulator (API 36).
