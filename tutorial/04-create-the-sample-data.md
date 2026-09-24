# Step 04 - Create the Sample Data & Helpers

## What We're Building

In this step, we will set up our central data hub in `lib/data/sample_data.dart`. This single file gives our app:
1. **`sampleCourts`**: An inventory list of four real campus sports facilities with descriptions, locations, icons, and available time slots.
2. **`sessionBookings`**: A mutable list sitting in device memory that stores student reservations while the app is open.
3. **`formatDate()`**: A tiny, zero-dependency helper function that turns raw Dart dates (like `2026-09-24`) into friendly strings (like `Thu, Sep 24, 2026`).

```text
lib/
├── main.dart
├── models/
│   ├── court.dart
│   └── booking.dart
└── data/
    └── sample_data.dart   <-- Seed venues, active bookings, & date formatter
```

---

## What You'll Learn

* How Dart **Lists** store collections of objects inside square brackets `[ ... ]`
* Why **in-memory state** keeps workshop projects simple and fast
* How to write a **helper function** that takes input and returns a string
* How **string interpolation** works using `$variable` and `${expression}`
* How 0-based list indexing works (and how to dodge "out-of-range" errors)

---

## Programming Concepts for Complete Beginners

### 1. What is a List?
When you have multiple items of the same kind, you don't create separate variables like `court1`, `court2`, `court3`. You group them into a **List**:

```dart
List<String> sports = ['Badminton', 'Basketball', 'Tennis'];
```
In our project, `List<Court>` holds our four campus venues, and `List<Booking>` holds confirmed reservations.

### 2. Why In-Memory State?
A lot of tutorials push you straight into cloud databases like Firebase on day one. That's great for production, but in a workshop it means API keys, billing setups, and network errors.

Instead, we use **in-memory storage**:
* The list `sessionBookings` lives right in your phone's RAM while the app runs.
* You book a court? We call `sessionBookings.add(...)`.
* You cancel? We call `sessionBookings.removeWhere(...)`.
* It's instant, completely offline, and lets us focus on learning Flutter.

### 3. The "Zero-Index" Rule (Elevator Analogy)
In programming, counting starts at **0**, not 1. Think of European elevators: the ground floor is floor 0, and the floor above it is floor 1.

Dart's `DateTime.month` gives you a number from `1` (January) to `12` (December). But our list of month names `['Jan', 'Feb', ...]` puts `'Jan'` at index `0`.
To get the right label, we subtract 1:
```dart
months[date.month - 1]
```
For January (`1`), `1 - 1 = 0`, which correctly pulls `'Jan'`.

### 4. String Interpolation (`$`)
Instead of gluing strings together with messy plus signs:
`"Today is " + weekday + ", " + month`
Dart lets you inject variables directly inside quotes using `$`:
`"$weekday, $month ${date.day}, ${date.year}"`
If you need to evaluate an expression (like accessing a property), wrap it in curly braces `${court.name}`.

---

## Step 1 - Create `lib/data/sample_data.dart`

In your editor, create a new folder named `data` inside `lib/`.

Inside `lib/data/`, create `sample_data.dart`:

```text
lib/
└── data/
    └── sample_data.dart
```

---

## Step 2 - Add Imports and Seed Facilities

Open `lib/data/sample_data.dart` and add the imports and initial court inventory:

```dart
import 'package:flutter/material.dart';
import '../models/court.dart';
import '../models/booking.dart';

final List<Court> sampleCourts = [
  const Court(
    id: 'court_1',
    name: 'Central Sports Arena',
    sport: 'Badminton',
    location: 'Main Campus, Building A',
    description:
        'Indoor air-conditioned wooden court with tournament-grade lighting and professional net systems.',
    icon: Icons.sports_tennis,
    availableSlots: ['09:00 AM', '10:00 AM', '11:00 AM', '04:00 PM', '05:00 PM'],
  ),
  const Court(
    id: 'court_2',
    name: 'Indoor Basketball Court',
    sport: 'Basketball',
    location: 'Sports Complex, Ground Floor',
    description:
        'Full-court maple wood flooring with adjustable FIBA backboards and electronic scoreboards.',
    icon: Icons.sports_basketball,
    availableSlots: ['08:00 AM', '10:00 AM', '02:00 PM', '06:00 PM', '07:00 PM'],
  ),
  const Court(
    id: 'court_3',
    name: 'Tennis Court 01',
    sport: 'Tennis',
    location: 'Outdoor Athletic Fields',
    description:
        'Synthetic hard court with high-visibility floodlights for evening play and shaded player benches.',
    icon: Icons.sports_tennis,
    availableSlots: ['07:00 AM', '09:00 AM', '03:00 PM', '05:00 PM', '06:00 PM'],
  ),
  const Court(
    id: 'court_4',
    name: 'Squash Studio North',
    sport: 'Squash',
    location: 'Student Activity Hub',
    description:
        'Glass-backed international competition court with shock-absorbent sprung floor.',
    icon: Icons.sports_handball,
    availableSlots: ['11:00 AM', '12:00 PM', '01:00 PM', '04:00 PM', '08:00 PM'],
  ),
];
```

> **Quick Note:** The `../` in `../models/court.dart` means "step up one folder out of `data/`, then step into `models/`."

---

## Step 3 - Add `sessionBookings` and `formatDate`

Directly below `sampleCourts` in the same file, add:

```dart
final List<Booking> sessionBookings = [];

String formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final weekday = weekdays[date.weekday - 1];
  final month = months[date.month - 1];
  return '$weekday, $month ${date.day}, ${date.year}';
}
```

### Why write our own `formatDate()`?
You could install a package like `intl` to format dates. But for a simple format like `Thu, Sep 24, 2026`, writing 15 lines of pure Dart keeps the project lean, eliminates dependencies, and shows you how list lookups work behind the scenes.

---

## Step 4 - Verify with `flutter analyze`

Run the static analysis check in your terminal:

```bash
flutter analyze
```

---

## What You Should See

```text
Analyzing court_booker...
No issues found! (ran in 0.8s)
```

Zero errors. All seed data, active booking lists, and date tools are ready for the UI.

---

## Gotchas & Fixes

### 1. `Target of URI doesn't exist: '../models/court.dart'`
* **What happened**: Typo in the import path, or `court.dart` is in the wrong directory.
* **The fix**: Make sure the folder is named `models` (all lowercase) inside `lib/`.

### 2. `RangeError (index): Index out of range`
* **What happened**: Forgetting the `- 1` when indexing `months` or `weekdays`.
* **The fix**: In Dart, index `12` does not exist in a 12-item list (valid indices are `0` through `11`). Double-check that your code uses `date.month - 1` and `date.weekday - 1`.

---

## Checkpoint

You can move to Step 05 once:

- [ ] `lib/data/sample_data.dart` exists and passes `flutter analyze`.
- [ ] `sampleCourts` defines all four facilities.
- [ ] `sessionBookings` starts as an empty list `[]`.
- [ ] `formatDate()` outputs formatted dates without errors.

---

## What You Learned

* A `List<T>` is an ordered collection of elements of type `T`.
* In-memory storage keeps data in RAM for fast, dependency-free development.
* Dart lists use 0-based indexing: `list[0]` is the first item.
* String interpolation (`$var` and `${expr}`) keeps string formatting clean.
* Pure Dart helper functions save you from importing heavy third-party packages for simple tasks.

Next: [Step 05 - Build the Home Screen](05-build-the-home-screen.md)
