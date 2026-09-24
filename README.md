# Court Booker 🏸🏀🎾

A clean, modern, beginner-friendly sports court booking application built with Flutter & Material 3 for the **GDSC Flutter App Development Workshop 2026**.

Court Booker provides a full interactive booking experience—browsing courts, selecting dates, picking time slots with check indicators, reviewing reservations in dialogs, and managing session bookings with full cancellation and empty states.

---

## 📱 Features

- **Facility Discovery**: Browse available campus courts (Badminton, Basketball, Tennis, Squash) with facility details, locations, and real-time slot availability counts.
- **Interactive Date Selection**: Native Material 3 date picker restricted to upcoming dates (up to 30 days ahead).
- **Time Slot Selection**: Accessible slot selection with distinct high-contrast color highlighting and checkmark icons for colorblind accessibility.
- **Booking Confirmation Flow**: Interactive modal dialog summarizing court name, date, and selected time slot before confirming.
- **My Bookings Dashboard**: Manage all session reservations with sport chips, dates, times, and confirmed status indicators.
- **Cancellation & Empty States**: Safe cancellation with confirmation dialogs and an inviting empty state that guides users back to available facilities.
- **Badge Counter**: Live AppBar badge dynamically reflecting total active reservations.

---

## 🏛️ Architecture & Workshop Design

Designed specifically for teaching Flutter to beginners in a 2-hour live coding session:

- **Zero External Dependencies**: Built strictly using Flutter SDK and standard Dart libraries.
- **Predictable State**: Local `setState()` and an in-memory session store (`sample_data.dart`) for transparent, teachable state management.
- **Material 3 Theming**: Athletic Forest Green palette (`#1E6F5C`) with surface elevation and high contrast.
- **Accessibility First**: WCAG AA compliant with minimum 48x48 dp touch targets, clear semantic labels, and dual-coded indicators (color + icons).

---

## 📂 Project Structure

```text
lib/
├── main.dart                      # App entry point, MaterialApp, and Material 3 theme
├── models/
│   ├── court.dart                 # Court data model
│   └── booking.dart               # Booking data model
├── data/
│   └── sample_data.dart           # Mock facilities, session store, date formatting
├── screens/
│   ├── home_screen.dart           # Facility browsing & welcome banner
│   ├── court_details_screen.dart  # Date picker, slot selection, confirmation dialog
│   └── bookings_screen.dart       # Reservations management & empty state
└── widgets/
    ├── court_card.dart            # Reusable court card widget
    └── booking_card.dart          # Reusable booking card widget with cancel action
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `3.47.5` or later
- Dart SDK `3.13.4` or later

### Installation & Run

```bash
# Clone the repository
git clone https://github.com/SH1SHANK/gdsc-court-booker.git
cd gdsc-court-booker

# Get dependencies
flutter pub get

# Run on connected device or emulator
flutter run
```

### Running Tests & Static Analysis

```bash
# Analyze code quality
flutter analyze

# Run widget and accessibility test suite
flutter test
```
