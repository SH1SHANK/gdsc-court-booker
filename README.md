<p align="center">
  <img src="assets/GDSC%20Banner.jpg" alt="Google Developer Student Clubs Banner" width="100%" />
</p>

# Court Booker

A lightweight campus sports court booking system built with Flutter and Dart for the Google Developer Student Clubs (GDSC) App Dev Workshop 2026.

[![Latest Release](https://img.shields.io/github/v/release/SH1SHANK/gdsc-court-booker?color=1E6F5C&label=Release)](https://github.com/SH1SHANK/gdsc-court-booker/releases/latest)
[![Download Universal APK](https://img.shields.io/badge/Download-Universal%20APK-2ea44f?logo=android&logoColor=white)](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-universal-release.apk)
[![Flutter](https://img.shields.io/badge/Flutter-3.47.5-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13.4-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Tests](https://img.shields.io/badge/Tests-4%20passing-brightgreen)](test/widget_test.dart)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Workshop](https://img.shields.io/badge/GDSC%20Workshop-2026-EA4335?logo=google&logoColor=white)](https://github.com/SH1SHANK/gdsc-court-booker)

---

## Downloads & Releases

Pre-compiled production Android binaries for the latest release (`v1.0.0`) are available for direct installation:

| Architecture | Package Size | Target Devices | Direct Download |
| :--- | :--- | :--- | :--- |
| **Universal** | 47.1 MB | All supported Android devices (FAT binary) | [![Universal APK](https://img.shields.io/badge/Download-Universal%20APK-2ea44f?logo=android&logoColor=white)](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-universal-release.apk) |
| **ARM64 (64-bit)** | 16.4 MB | Modern Android smartphones and tablets (`arm64-v8a`) | [![ARM64 APK](https://img.shields.io/badge/Download-arm64--v8a-2ea44f?logo=android&logoColor=white)](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-arm64-v8a-release.apk) |
| **ARMv7 (32-bit)** | 13.9 MB | Older 32-bit Android hardware (`armeabi-v7a`) | [![ARMv7 APK](https://img.shields.io/badge/Download-armeabi--v7a-2ea44f?logo=android&logoColor=white)](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-armeabi-v7a-release.apk) |
| **x86_64** | 17.8 MB | Android Emulators, ChromeOS, and x86 devices (`x86_64`) | [![x86_64 APK](https://img.shields.io/badge/Download-x86__64-2ea44f?logo=android&logoColor=white)](https://github.com/SH1SHANK/gdsc-court-booker/releases/download/v1.0.0/app-x86_64-release.apk) |

Full release notes, source code archives, and verified checksums are published on the [GitHub Releases Page](https://github.com/SH1SHANK/gdsc-court-booker/releases/tag/v1.0.0).

---

## Executive Summary

Court Booker is a mobile sports court booking application designed for university athletic complexes and student communities. The system addresses campus recreational scheduling bottlenecks—such as court crowding, uncertain slot availability, and coordination delays—by providing an open facility board with real-time slot tracking and reservation lifecycle management.

Engineered with Flutter's core framework primitives, the application demonstrates production-grade engineering principles: predictable unidirectional data flow, explicit state ownership, disciplined resource lifecycle management, dual-coded accessibility, and comprehensive widget test coverage without third-party dependencies.

---

## Workshop Tutorial Curriculum

Looking for the step-by-step beginner tutorial? Follow the hands-on curriculum in the [`tutorial/`](tutorial/README.md) directory:
* [Tutorial Master Guide](tutorial/README.md)
* [Step 01: Create the Project](tutorial/01-create-the-project.md)
* [Step 02: Build the App Shell](tutorial/02-build-the-app-shell.md)
* [Step 03: Create the Domain Models](tutorial/03-create-the-domain-models.md)
* [Step 04: Create the Sample Data & Helpers](tutorial/04-create-the-sample-data.md)
* [Step 05: Build the Home Screen](tutorial/05-build-the-home-screen.md)
* [Step 06: Extract the Court Card Widget](tutorial/06-extract-the-court-card-widget.md)
* [Step 07: Add Navigation & AppBar Badge](tutorial/07-add-navigation-and-app-badge.md)
* [Step 08: Build the Court Details Screen](tutorial/08-build-the-court-details-screen.md)
* [Step 09: Add the Interactive Date Picker](tutorial/09-add-the-date-picker.md)
* [Step 10: Build Interactive Slot Chips](tutorial/10-build-interactive-slot-chips.md)
* [Step 11: Booking Confirmation Dialog](tutorial/11-booking-confirmation-dialog.md)
* [Step 12: Build the My Bookings Screen](tutorial/12-build-the-my-bookings-screen.md)
* [Step 13: Add Cancellation Safeguard](tutorial/13-add-cancellation-safeguard.md)
* [Step 14: Architecture & Verification](tutorial/14-architecture-and-verification.md)

---

## System Architecture

The application adopts a modular, domain-driven layered architecture that cleanly separates presentation concerns, state management, and domain models.

### Directory Structure

```text
lib/
├── main.dart
├── models/
│   ├── court.dart
│   └── booking.dart
├── data/
│   └── sample_data.dart
├── screens/
│   ├── home_screen.dart
│   ├── court_details_screen.dart
│   └── bookings_screen.dart
└── widgets/
    ├── court_card.dart
    └── booking_card.dart
```

### Module Responsibilities

| Layer / File | Component Type | Primary Responsibility |
| :--- | :--- | :--- |
| `lib/main.dart` | Application Bootstrap | Configures the application entry point, root `MaterialApp`, and global Material 3 theme scheme (`#1E6F5C`). |
| `lib/models/court.dart` | Domain Model | Defines the court domain entity with identifiers, sport classification, facility description, location, icon, and slot schedules. |
| `lib/models/booking.dart` | Domain Model | Defines the reservation domain entity (`Booking`) with timestamps, court references, sport tags, and confirmation status. |
| `lib/data/sample_data.dart` | Data & Session Store | Houses static campus facility seed data, mutable in-memory session reservations list (`sessionBookings`), and zero-dependency date formatting. |
| `lib/screens/home_screen.dart` | Root Screen & State Controller | Displays welcoming hero banner, facility inventory, live AppBar reservation badge, and coordinates navigation. |
| `lib/screens/court_details_screen.dart` | Detail View & Reservation Form | Manages interactive date picking (`showDatePicker`), time-slot selection with visual verification, and reservation confirmation modal. |
| `lib/screens/bookings_screen.dart` | Management & Empty State | Displays active user bookings, coordinates cancellation confirmation dialogs, and renders guidance empty states. |
| `lib/widgets/court_card.dart` | Atomic UI Component | Renders facility overview card with sport badge, location pin, description preview, and booking trigger. |
| `lib/widgets/booking_card.dart` | Atomic UI Component | Renders confirmed reservation card with formatted date/time stamps, status badge, and cancellation action. |

---

## Technical Architecture & State Flow

### Unidirectional Data Flow

Application state is held in transparent session memory and propagated downwards through explicit typed interfaces, while user actions bubble upwards via standard Flutter navigation and `setState()`:

1. **Downwards Propagation**: State is passed down to child widgets and pushed routes through constructor arguments (`CourtCard(court: ...)`, `CourtDetailsScreen(court: court)`).
2. **Upwards Notification**: State changes are communicated back to parent screens through asynchronous navigation returns (`await Navigator.push(...)`) followed by `setState()` re-renders that dynamically refresh the AppBar reservation badge.

```text
                   +-------------------------------+
                   |          HomeScreen           |
                   |   (Inventory & Badge State)   |
                   +---------------+---------------+
                                   |
         +-------------------------+-------------------------+
         |                                                   |
         v                                                   v
+------------------+                              +--------------------+
|    CourtCard     |                              |   BookingsScreen   |
| (Pure UI Render) |                              | (List & Cancel UI) |
+--------+---------+                              +---------+----------+
         |                                                  |
         | onTap() / Navigator.push                         | Cancel Booking
         v                                                  v
+----------------------+                          +--------------------+
|  CourtDetailsScreen  |                          | Confirmation Alert |
| (Date & Slot Choice) |                          | (setState Remove)  |
+----------+-----------+                          +--------------------+
           |
           | Review & Confirm Modal
           v
+----------------------+
|  sessionBookings.add |
|   (Push My Bookings) |
+----------------------+
```

### Finite State Machine (Reservation Lifecycle)

Every court reservation conforms to a deterministic finite state machine from initial discovery to session completion or cancellation:

```text
       [ Browse Facilities ]
                 |
                 v
           +-----------+
           | AVAILABLE | <------------------ Available Slots on Facility Card
           +-----+-----+
                 |
                 | Select Date & Slot (CourtDetailsScreen)
                 v
           +-----------+
           | REVIEWING | <------------------ Confirmation Dialog
           +-----+-----+
                 |
                 | Confirm Booking (sessionBookings.add)
                 v
           +-----------+
           | CONFIRMED | <------------------ Active in "My Bookings" & Badge Count
           +-----+-----+
                 |
                 | Cancel Booking (Confirmation Dialog -> sessionBookings.removeWhere)
                 v
           +-----------+
           | CANCELLED | <------------------ Removed from Session; Shows Empty State if 0
           +-----------+
```

State transition rules:
* **Selection**: Requires explicit date and time-slot selection; confirm action is disabled (`onPressed: null`) until a slot is chosen.
* **Review**: Triggered by user interaction; displays full details modal before state modification.
* **Confirmation**: Instantiates an immutable `Booking`, appends to `sessionBookings`, provides immediate feedback via floating `SnackBar`, and transitions to `BookingsScreen`.
* **Cancellation**: Requires explicit affirmative confirmation in `AlertDialog` prior to state deletion; triggers `setState()` removal and updates live badge count.

---

## Engineering Details

### State Management Strategy
* **Zero External Dependencies**: The application utilizes Flutter's native `StatefulWidget` and `setState()` primitives, avoiding the overhead, boilerplate, and dependency coupling of external state management libraries (Provider, Riverpod, Bloc, GetX).
* **Predictable Garbage Collection & Resource Lifecycle**: Input and scroll controllers are safely bound to standard Flutter lifecycles, eliminating memory leaks and dangling subscriptions.
* **Separation of Presentation and Business Logic**: Pure presentation widgets (`CourtCard`, `BookingCard`) possess no state mutators or route handling logic, maximizing testability and reusability.

### Date & Slot Validation Engine
* **Date Bounds**: Integrates Flutter's Material 3 `showDatePicker` restricted from `today` to 30 days ahead (`today.add(const Duration(days: 30))`), preventing invalid past reservations.
* **Slot Selection Gate**: The primary action button remains disabled (`onPressed: null`) until an available slot is selected, accompanied by a dynamic helper label: *"Please select a time slot to continue."*
* **Dual-Coded Accessibility**: Selected slots use both contrasting color fills (`colorScheme.primary`) and explicit check icons (`Icons.check_circle_rounded`), ensuring full usability for colorblind individuals.

---

## Testing Strategy & Quality Assurance

The codebase includes an automated widget and accessibility test suite in `test/widget_test.dart` that validates UI rendering, navigation pipelines, slot selection, confirmation dialogs, CRUD operations, and WCAG AA compliance.

### Test Matrix

| Test Suite | Target Feature | Validation Criteria |
| :--- | :--- | :--- |
| `Renders home screen with title, welcome banner, and sample courts` | Facility Feed Rendering | Verifies campus branding, promotional hero card, facility list rendering, and slot availability counters. |
| `Navigates to court details, selects slot, confirms booking, and displays in My Bookings` | Booking Flow & State Machine | Tests route push to `CourtDetailsScreen`, date display, slot selection, dual-indicator check icon, modal verification dialog, list insertion, and redirect to `BookingsScreen`. |
| `Can cancel a booking and display the empty state` | Cancellation & Empty States | Verifies cancel action on `BookingCard`, deletion safeguard dialog prompt, list removal via `setState()`, and fallback to polished empty state with "Browse Courts" trigger. |
| `Meets accessibility tap target and labeling guidelines on Home screen` | WCAG AA Accessibility | Validates full compliance against `androidTapTargetGuideline` (minimum 48x48 dp) and `labeledTapTargetGuideline`. |

### Quality Enforcement Commands

Run static code analysis:
```bash
flutter analyze
```

Verify formatting compliance:
```bash
dart format --output=none --set-exit-if-changed lib test
```

Execute automated test suite:
```bash
flutter test
```

---

## System Requirements & Toolchain

| Component | Specification |
| :--- | :--- |
| Framework | Flutter 3.47.5 (Channel Stable) |
| Runtime | Dart 3.13.4 |
| Target Environments | Android (API 21+), macOS Desktop, iOS (12.0+), Web (WASM / CanvasKit) |
| Architecture Standard | Material Design 3 (`useMaterial3: true`) |
| Primary Color Seed | Athletic Forest Green (`#1E6F5C`) |
| Package Dependencies | None (`flutter` SDK only) |

---

## Local Setup & Execution

### 1. Environment Preparation
Verify your local Flutter environment passes all system health checks:
```bash
flutter doctor
```

### 2. Dependency Resolution
Fetch internal Flutter SDK packages:
```bash
flutter pub get
```

### 3. Execution Targets

* **Android Emulator / Connected Device**:
  ```bash
  flutter run -d <device_id>
  ```
  *(To list attached devices: `flutter devices`)*

* **macOS Desktop**:
  ```bash
  flutter run -d macos
  ```

* **Web Browser (Google Chrome)**:
  ```bash
  flutter run -d chrome
  ```

---

## Cloud Integration Roadmap (Firebase Architecture Preview)

The Court Booker in-memory state contracts are specifically structured to map directly to a cloud document database (Google Cloud Firestore):

```text
In-Memory Contract                     Cloud Datastore Equivalent (Firestore)
----------------------------------     ---------------------------------------
List<Booking> sessionBookings      -->  CollectionReference ('bookings')
sampleCourts                       -->  CollectionReference ('courts')
sessionBookings.add(newBooking)    -->  collection('bookings').add(newBooking.toMap())
sessionBookings.removeWhere(...)   -->  documentReference.delete()
setState(() {})                    -->  StreamBuilder<QuerySnapshot> / StreamSubscription
```

By decoupling presentation from storage mechanisms, cloud persistence can be introduced without altering UI layouts, widget boundaries, or page contracts.

---

## License & Attribution

Developed as reference curriculum for the **GDSC Flutter App Development Workshop 2026**.
Google Developer Student Clubs (GDSC). Distributed under the [MIT License](LICENSE).
