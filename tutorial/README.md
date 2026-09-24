# Court Booker Tutorial

Welcome to the **Court Booker** workshop guide. We built this tutorial for the **Google Developer Student Clubs (GDSC) Flutter App Development Workshop 2026**.

You do not need any coding background to follow along. None. If you have never opened a terminal, written a line of Dart, or built a mobile layout, you are in the right place. We explain every concept as it comes up, using plain language and everyday examples.

---

## What We're Building

**Court Booker** is an on-campus sports venue booking app. It solves a headache every college student knows: showing up at the court with your racket, only to find three groups already waiting in line.

Here is what the finished app does:
1. **Browse Courts**: Look through campus sports facilities (Badminton, Basketball, Tennis, Squash) with live slot counts, locations, and descriptions.
2. **Pick a Date & Time**: Choose any date over the next 30 days using Flutter's built-in calendar, then tap an open hourly time slot.
3. **Review & Confirm**: Double-check the reservation details in a quick confirmation modal before locking it in.
4. **Track Bookings**: Check your active reservations on a dedicated "My Bookings" page, with a live count badge sitting right on the home screen navigation bar.
5. **Cancel Cleanly**: Drop a reservation whenever plans change. A safety dialog makes sure you never delete a booking by accident.

Everything runs straight in device memory using Flutter's built-in state tools (`StatefulWidget` and `setState()`). No backend to spin up. No database credentials. No cloud bills. Just pure Flutter.

---

## What You'll Learn

By the time you finish this guide, you will know your way around:
* **Dart Basics**: Variables, types, classes, objects, constructors, lists, functions, and async code (`Future`, `async`, `await`).
* **Flutter Layouts**: The Widget Tree, and the workhorse widgets you will use every day (`Column`, `Row`, `Container`, `Card`, `Padding`, `ListView`, `Wrap`).
* **Theme Setup**: Material Design 3 theming with custom brand colors.
* **State Management**: When to reach for `StatelessWidget` vs `StatefulWidget`, and how `setState()` tells Flutter to repaint the screen.
* **Navigation**: Moving between screens with `Navigator.push()` and `Navigator.pop()`, passing data into constructors, and showing dialogs and snackbars.
* **Accessible Touch Design**: 48x48 dp touch targets, clear screen-reader labels, and colorblind-friendly visual cues.
* **Project Architecture**: How to keep code organized so you can still find things next week (`models/`, `data/`, `screens/`, `widgets/`).

---

## What You Need Before Starting

Get these ready on your laptop before diving into Step 1:
* **Flutter SDK**: Version 3.47.5 (Stable channel) or newer
* **Dart SDK**: Version 3.13.4 or newer
* **Code Editor**: [Visual Studio Code](https://code.visualstudio.com/) with the Flutter and Dart extensions, or Android Studio.
* **A Screen to Test On**: An Android emulator, an iOS simulator, your macOS desktop, or Google Chrome.

Open your terminal and run these two commands to confirm your machine is ready:

```bash
flutter --version
flutter doctor
```

If `flutter doctor` gives you green checkmarks for Flutter and at least one connected device, you're set.

---

## Project Structure

Here is how your `lib/` directory will look once everything is built:

```text
lib/
├── main.dart                      <-- Boots the app and configures the green theme
├── models/
│   ├── court.dart                 <-- Blueprint for sports venues
│   └── booking.dart               <-- Blueprint for student reservations
├── data/
│   └── sample_data.dart           <-- Seed courts, session bookings list, and date helper
├── screens/
│   ├── home_screen.dart           <-- Catalog screen with hero banner and badge
│   ├── court_details_screen.dart  <-- Date picker, slot chips, and confirmation modal
│   └── bookings_screen.dart       <-- Active reservations and empty state
└── widgets/
    ├── court_card.dart            <-- Reusable venue card on the home screen
    └── booking_card.dart          <-- Reusable reservation card with cancel action
```

### Quick File Breakdown

| File | What it is | What it handles |
| :--- | :--- | :--- |
| `lib/main.dart` | Entry Point | Calls `runApp()` and applies the Material 3 forest green theme (`#1E6F5C`). |
| `lib/models/court.dart` | Data Model | Holds the properties of a court (name, sport, location, slots, icon). |
| `lib/models/booking.dart` | Data Model | Holds the reservation details (court name, date, time slot, status). |
| `lib/data/sample_data.dart` | Data Store | Stores default courts, the mutable `sessionBookings` list, and `formatDate()`. |
| `lib/screens/home_screen.dart` | Screen | The main directory screen with the hero card and notification badge. |
| `lib/screens/court_details_screen.dart` | Screen | Where the user picks a date, picks an open slot, and confirms. |
| `lib/screens/bookings_screen.dart` | Screen | Shows all current user bookings, plus the empty state when list is empty. |
| `lib/widgets/court_card.dart` | Component | Renders one court card with sport tag, location, and "Book Court" button. |
| `lib/widgets/booking_card.dart` | Component | Renders one confirmed booking with timestamps and a cancel button. |

---

## How This Guide Works

Work through the chapters in order. Don't skip straight to the end; each step builds on the code from the previous one.

Every chapter follows the same flow:
1. **The Idea**: What we need and why, explained with analogies.
2. **The Code**: Exact files to create or modify, with line-by-line breakdowns.
3. **Run It**: Hot reload (`r`) or hot restart (`R`) to test right away.
4. **Check Your Screen**: Exactly what you should see if things went right.
5. **Gotchas & Fixes**: Common beginner slip-ups (missing semicolons, bracket mismatches) and how to fix them fast.

---

## Tutorial Roadmap

* [Step 01 - Create the Project](01-create-the-project.md): Generate the Flutter app, tour the folder structure, and run the counter app.
* [Step 02 - Build the App Shell](02-build-the-app-shell.md): Set up `main()`, `runApp()`, `MaterialApp`, and the athletic green theme.
* [Step 03 - Create the Domain Models](03-create-the-domain-models.md): Understand classes and types by building `Court` and `Booking`.
* [Step 04 - Create the Sample Data & Helpers](04-create-the-sample-data.md): Set up seed court data, session state, and a clean date formatter.
* [Step 05 - Build the Home Screen](05-build-the-home-screen.md): Work with `StatefulWidget`, build a gradient hero banner, and use `ListView`.
* [Step 06 - Extract the Court Card Widget](06-extract-the-court-card-widget.md): Build a reusable `CourtCard` component with ripple effects and screen-reader support.
* [Step 07 - Add Navigation & AppBar Badge](07-add-navigation-and-app-badge.md): Push routes with `Navigator.push()` and add a dynamic reservation badge.
* [Step 08 - Build the Court Details Screen](08-build-the-court-details-screen.md): Use `initState()`, handle nullable values, and render court details.
* [Step 09 - Add the Interactive Date Picker](09-add-the-date-picker.md): Learn `async`/`await` and `Future` by wiring up Flutter's calendar dialog.
* [Step 10 - Build Interactive Slot Chips](10-build-interactive-slot-chips.md): Lay out responsive time chips with `Wrap`, toggle selection, and gate the confirm button.
* [Step 11 - Booking Confirmation Dialog](11-booking-confirmation-dialog.md): Pop up review dialogs with `AlertDialog`, append to session memory, and show a SnackBar.
* [Step 12 - Build the My Bookings Screen](12-build-the-my-bookings-screen.md): Build `BookingsScreen` and `BookingCard`, complete with an empty state.
* [Step 13 - Add Cancellation Safeguard](13-add-cancellation-safeguard.md): Protect deletions with a confirmation dialog and update lists reactively.
* [Step 14 - Architecture & Verification](14-architecture-and-verification.md): Review CRUD mapping, run the automated tests, and test yourself on 15 core concepts.

---

Ready? Let's get your hands dirty in [Step 01 - Create the Project](01-create-the-project.md).
