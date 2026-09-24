# Court Booker v1.0.0 — Initial Release

Official v1.0.0 release of **Court Booker**, the reference sports court booking application built for the Google Developer Student Clubs (GDSC) App Dev Workshop 2026.

This release establishes the baseline architecture, core mobile UI, in-memory state management, accessible time-slot reservation system, comprehensive widget test coverage, and complete workshop documentation.

---

## Downloads & Binary Distribution

Pre-compiled production Android binaries for release `v1.0.0` are available for direct installation:

| Architecture | Package Size | Target Devices | Direct Download | SHA-256 Checksum |
| :--- | :--- | :--- | :--- | :--- |
| **Universal** | 47.1 MB | All supported Android devices (FAT binary) | [app-universal-release.apk](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-universal-release.apk) | `4d4fe54e8b47f8a5f21f8c1a84abee4fb703539d5cb8499145884836a2c0265e` |
| **ARM64 (64-bit)** | 16.4 MB | Modern Android smartphones and tablets (`arm64-v8a`) | [app-arm64-v8a-release.apk](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-arm64-v8a-release.apk) | `92f6a8e6efd460cb62e42f3d74d0400f5a5e4e544ded0b01f6cdc2081d18d15b` |
| **ARMv7 (32-bit)** | 13.9 MB | Older 32-bit Android hardware (`armeabi-v7a`) | [app-armeabi-v7a-release.apk](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-armeabi-v7a-release.apk) | `8a73ed124a341aba967ec404a90e42c631f9700885eba31dfa9587487f9f6023` |
| **x86_64** | 17.8 MB | Android Emulators, ChromeOS, and x86 devices (`x86_64`) | [app-x86_64-release.apk](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-x86_64-release.apk) | `2e5bcd21b1e56f6090108dc37fbece420c5531b751c6aa7ac364e2a603f502b1` |

---

## What's New in v1.0.0

### Core Application Features
* **Campus Facility Discovery Feed**:
  * **Multi-Sport Inventory**: Real-time browsing of campus sports facilities including Badminton (Central Sports Arena), Basketball (Indoor Basketball Court), Tennis (Tennis Court 01), and Squash (Squash Studio North).
  * **Facility Metadata Cards**: Dedicated cards displaying sport icon containers, sport chips, venue locations with pins, amenity descriptions, and active slot counts.
  * **Dynamic AppBar Badge Counter**: Live reservation count displayed directly over the My Bookings action button in the AppBar.
* **Reservation Lifecycle & State Transitions**:
  * **Facility Inspection**: Detailed view with venue amenities, address, full descriptions, and booking configuration.
  * **Date Picker Engine**: Built-in Material 3 date picker restricted from today to 30 days in advance (`today.add(Duration(days: 30))`), preventing invalid past reservations.
  * **Dual-Coded Time Slot Selection**: Choice chips with high-contrast athletic green selection and checkmark icons (`Icons.check_circle_rounded`) for colorblind accessibility.
  * **Booking Gate Validation**: Disables confirmation actions (`onPressed: null`) until a valid time slot is selected, with helper instructions.
  * **Modal Confirmation Dialog**: Verification alert summarizing court name, formatted date, and selected time slot before appending the reservation.
  * **My Bookings Dashboard**: Unified tracking for all confirmed bookings created during the session.
  * **Cancellation Safeguard**: Interactive `AlertDialog` prevents accidental booking deletion, with instant feedback via floating `SnackBar`.
  * **Empty-State Fallback**: Polished empty state with guidance and a 1-tap "Browse Courts" button returning users to available facilities.

---

### Architectural Highlights
* **Clean Multi-File Modular Design**:
  * `lib/main.dart`: Minimal entry point bootstrapping `MaterialApp` and Material 3 athletic theming.
  * `lib/models/court.dart`: Domain entity (`Court`) representing sports facilities, sports types, descriptions, and slot schedules.
  * `lib/models/booking.dart`: Domain entity (`Booking`) modeling confirmed reservations with IDs, court references, dates, and times.
  * `lib/data/sample_data.dart`: Campus facility seed data, mutable in-memory session store (`sessionBookings`), and zero-dependency date formatting.
  * `lib/screens/home_screen.dart`: Master state owner and feed coordinator managing court discovery and AppBar badges.
  * `lib/screens/court_details_screen.dart`: Interactive detail view coordinating date picker, slot selection, and confirmation dialogs.
  * `lib/screens/bookings_screen.dart`: Reservation management dashboard with cancellation workflows and empty-state fallbacks.
  * `lib/widgets/court_card.dart`: Decoupled, reusable court presentation card with touch-target compliance.
  * `lib/widgets/booking_card.dart`: Decoupled, reusable booking card displaying timestamps and cancellation actions.
* **Predictable Native State Management**:
  * Implemented strictly using Flutter's native `StatefulWidget` and `setState()` primitives.
  * Zero third-party state management dependencies (no Provider, Riverpod, Bloc, GetX) for maximum clarity and beginner accessibility.
* **Accessibility & Ergonomics (WCAG AA)**:
  * Guarantees minimum 48x48 dp touch targets across all interactive buttons, cards, and chips.
  * Verified against Flutter's accessibility guidelines (`androidTapTargetGuideline` and `labeledTapTargetGuideline`).
  * High-contrast typography and dual-coded indicators (color + checkmark icon).

---

### Testing & Quality Assurance
* **Automated Widget Test Suite (`test/widget_test.dart`)**:
  * **Test 1**: Facility feed rendering, campus branding, welcome banner, and sample court cards.
  * **Test 2**: Navigation pipeline (`HomeScreen` -> `CourtDetailsScreen`), slot selection, checkmark appearance, confirmation modal dialog, list insertion, and redirect to `BookingsScreen`.
  * **Test 3**: Deletion modal cancellation safeguard, confirmed master list eviction, and fallback to polished empty state with "Browse Courts" navigation.
  * **Test 4**: Material accessibility validation ensuring tap targets and semantic labels meet Android accessibility standards.
* **Static Code Analysis**: Passed with 0 errors, 0 warnings, and 0 lints (`flutter analyze`).
* **Code Formatting**: 100% compliant with standard Dart styling (`dart format`).
* **End-to-End Device Verification**: Verified on Android Emulator (API 36).

---

### Documentation & Workshop Curriculum
* **Executive-Standard README**: Detailed system architecture, unidirectional data flow diagrams, finite state machine specifications, test matrices, and Cloud Firestore migration roadmap.
* **Open Source License**: Released under the MIT License (`LICENSE`).

---

### Toolchain & Target Specifications
* **Framework**: Flutter 3.47.5 (Channel Stable)
* **Language Runtime**: Dart 3.13.4
* **UI Standard**: Material Design 3 (`useMaterial3: true`)
* **Primary Color Seed**: Athletic Forest Green (`#1E6F5C`)
* **Verified Environments**: Android (API 21+), macOS Desktop, iOS (12.0+), Web (WASM / CanvasKit)
