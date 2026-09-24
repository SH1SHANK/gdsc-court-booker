# Step 08 - Build the Court Details Screen

## What We're Building

Now we turn the stub in `lib/screens/court_details_screen.dart` into a rich, scrollable detail view.

In this step, we will add:
* An `AppBar` showing the court's name and a shortcut icon to "My Bookings"
* A prominent venue header card showing the court icon, sport badge, location pin, and full description
* State initialization for `selectedDate` and `selectedSlot` using Flutter's `initState()` lifecycle method

```text
+---------------------------------------+
| < Central Sports Arena            [🔖]|  <-- AppBar
+---------------------------------------+
| +-----------------------------------+ |
| | [🎾] Central Sports Arena         | |
| |      [ Badminton ]                | |  <-- Court Header Card
| |                                   | |
| | 📍 Main Campus, Building A        | |
| | Indoor air-conditioned wooden     | |
| | court with tournament-grade net...| |
| +-----------------------------------+ |
|                                       |
| [ Date & Slot chips coming next! ]    |
+---------------------------------------+
```

---

## What You'll Learn

* What **`initState()`** does and when Flutter runs it
* What a **nullable type** (`String?`) is and why Dart enforces **Null Safety**
* What the **`late`** keyword tells the Dart compiler
* How to grab parent widget values using **`widget.`**
* Why wrapping your layout in **`SingleChildScrollView`** stops small-screen overflow errors

---

## Programming Concepts for Complete Beginners

### 1. What is Null Safety? (The Empty Box Analogy)
In programming, **`null`** means "nothing" or "absence of a value."
In many older languages, reading a variable that happened to be null crashed the app with a "NullPointerException."

Dart uses **Sound Null Safety**:
* A regular `String courtName` **can never be null**. Dart prevents you from compiling if it could be empty.
* A `String? selectedSlot` with a question mark `?` explicitly tells Dart: *"This variable is allowed to be empty."*
  * When the user first lands on the page, no slot is picked yet, so `selectedSlot` is `null`.
  * As soon as they tap `'09:00 AM'`, `selectedSlot` holds `'09:00 AM'`.

### 2. Accessing Parent Fields with `widget.`
Remember: a `StatefulWidget` splits into two classes:
1. `CourtDetailsScreen` (where `final Court court;` was passed in).
2. `_CourtDetailsScreenState` (where your `build()` method lives).

To read variables from the configuration class inside your state class, Dart gives you **`widget.`**:
```dart
Text(widget.court.name) // Reads court.name from CourtDetailsScreen
```

### 3. What is `initState()`?
Widgets have a lifecycle. When a `StatefulWidget` is created and mounted to the screen, Flutter calls **`initState()`** exactly **once**:
```dart
@override
void initState() {
  super.initState();
  // One-time setup code goes here.
}
```
We use `initState()` to calculate today's date so the reservation date defaults to today.

---

## Step 1 - Update `lib/screens/court_details_screen.dart`

Open `lib/screens/court_details_screen.dart` and update it:

```dart
import 'package:flutter/material.dart';
import '../models/court.dart';
import '../data/sample_data.dart';
import 'bookings_screen.dart';

class CourtDetailsScreen extends StatefulWidget {
  final Court court;

  const CourtDetailsScreen({
    super.key,
    required this.court,
  });

  @override
  State<CourtDetailsScreen> createState() => _CourtDetailsScreenState();
}

class _CourtDetailsScreenState extends State<CourtDetailsScreen> {
  late DateTime selectedDate;
  String? selectedSlot;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    // Default to today at 00:00:00
    selectedDate = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.court.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            tooltip: 'My Bookings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BookingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Court Header Card
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            widget.court.icon,
                            color: colorScheme.onPrimaryContainer,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.court.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  widget.court.sport,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onSecondaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.court.location,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.court.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Run the App

Save `court_details_screen.dart`. Hit **`r`** for Hot Reload.

---

## What You Should See

1. On the home screen, tap any court (for instance, **Indoor Basketball Court**).
2. The details page opens:
   * The `AppBar` displays **Indoor Basketball Court**.
   * A large basketball icon sits in a rounded container.
   * The sport pill badge shows **Basketball**.
   * The location reads: **Sports Complex, Ground Floor**.
   * The full multi-line description renders cleanly.
3. Tap back and open **Squash Studio North** to confirm its unique icon, badge, and description show up correctly.

---

## Common Mistakes

### 1. Forgetting `widget.` to access properties from the state class
* **The mistake**: Trying to write `court.name` directly inside `_CourtDetailsScreenState`.
* **What you see**: `Undefined name 'court'.`
* **The fix**: `court` was passed into `CourtDetailsScreen`. Inside `_CourtDetailsScreenState`, access properties from the parent widget by prefixing them with `widget.`, e.g., `widget.court.name`.

### 2. Forgetting `super.initState()`
* **The mistake**: Leaving out `super.initState();` at the beginning of `initState()`.
* **What you see**: Flutter analyzer warning or subtle framework lifecycle bugs where state isn't initialized properly.
* **The fix**: The very first line inside any `initState()` method should always be `super.initState();`.

### 3. Re-initializing `selectedDate` inside `build()`
* **The mistake**: Writing `selectedDate = DateTime.now();` inside `Widget build(...)` instead of `initState()`.
* **What you see**: Whenever the user selects a new date or slot, `setState()` triggers `build()`, which immediately resets `selectedDate` back to today!
* **The fix**: Initialize default values once in `initState()`. That way, subsequent screen rebuilds will preserve the user's chosen date.

### 4. `LateInitializationError`
* **The mistake**: Declaring `late DateTime selectedDate;` but forgetting to set it inside `initState()`.
* **What you see**: A red crash screen with `LateInitializationError: Field 'selectedDate' has not been initialized`.
* **The fix**: Make sure `selectedDate = DateTime.now();` runs inside `initState()`.

---

## Checkpoint

You can move to Step 09 once:

- [ ] `lib/screens/court_details_screen.dart` compiles with zero errors.
- [ ] Tapping any court shows its specific icon, name, sport badge, location, and description.
- [ ] `selectedDate` initializes to today's date in `initState()`.

---

## What You Learned

* `initState()` runs once when a stateful widget enters the screen.
* `late` lets you initialize a variable inside `initState()` instead of right at declaration time.
* Nullable types with `?` (`String?`) safely handle values that start out empty.
* `widget.` lets you read constructor parameters passed into the parent `StatefulWidget`.
* `SingleChildScrollView` keeps longer pages scrollable across various phone heights.

Next: [Step 09 - Add the Interactive Date Picker](09-add-the-date-picker.md)
