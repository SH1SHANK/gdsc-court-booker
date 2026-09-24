# Step 03 - Create the Domain Models

## What We're Building

Before we build more UI, we need to teach Dart what a "court" and a "booking" actually look like in code. In this step, we will create two Dart data models:
1. **`Court`**: Blueprint for a campus facility (name, sport, location, available slots, icon).
2. **`Booking`**: Blueprint for a completed student reservation.

We'll place both files in a new `lib/models/` folder.

```text
lib/
├── main.dart
└── models/
    ├── court.dart    <-- Blueprint for a sports facility
    └── booking.dart  <-- Blueprint for a reservation
```

---

## What You'll Learn

* What a **data model** is and why apps need structured data
* Classes vs. Objects (explained with the cookie cutter analogy)
* Everyday Dart types: `String`, `DateTime`, `IconData`, and `List<String>`
* Why the **`final`** keyword prevents accidental data bugs
* How to write constructors with **named parameters** (`{ ... }`)
* What **`required`** does and how default values work

---

## Programming Concepts for Complete Beginners

### 1. Classes and Objects: The Cookie Cutter Analogy

Think of a bakery:
* A **Class** is the **cookie cutter**. It's the metal shape. You don't eat the cookie cutter; it simply decides what shape the cookie will have.
* An **Object** is an **actual cookie** stamped out of the dough. You can use the exact same cookie cutter to stamp out 100 cookies, each topped with different frosting or sprinkles.

In Court Booker:
* The **`Court` class** is our blueprint. It says: *"Every court in this app has a name, a sport, a location, an icon, and a list of time slots."*
* An **individual Court object** is the real facility: "Central Sports Arena" for Badminton, or "Tennis Court 01" for Tennis.

```text
+---------------------------------------+
|  CLASS (The Blueprint)                |
|  class Court {                        |
|    name, sport, location, slots       |
|  }                                    |
+---------------------------------------+
                   │
                   ▼  Instantiation (Stamping out objects)
+---------------------------------------+   +---------------------------------------+
|  OBJECT 1                             |   |  OBJECT 2                             |
|  name: "Central Sports Arena"         |   |  name: "Tennis Court 01"              |
|  sport: "Badminton"                   |   |  sport: "Tennis"                      |
|  location: "Building A"               |   |  location: "Athletic Fields"          |
+---------------------------------------+   +---------------------------------------+
```

### 2. Dart Data Types
Every piece of data has a specific type:
* **`String`**: Plain text inside quotes (`'Tennis Court 01'`).
* **`int`**: Whole numbers without decimals (`5`, `100`).
* **`bool`**: A true/false flag (`true` or `false`).
* **`DateTime`**: A specific calendar date and time.
* **`IconData`**: A Flutter icon identifier (`Icons.sports_tennis`).
* **`List<String>`**: An ordered list of text values (`['09:00 AM', '10:00 AM']`). The `<String>` inside the angle brackets guarantees that only text can go into this list.

### 3. What does `final` mean?
Marking a property `final` means: once it gets set when the object is created, it cannot be overwritten later. It keeps your data reliable and stops sneaky bugs from mutating values behind your back.

---

## Step 1 - Create `lib/models/court.dart`

In your file explorer, add a new folder named `models` inside `lib/`.

Inside `lib/models/`, create a new file named `court.dart`:

```text
lib/
└── models/
    └── court.dart
```

Open `lib/models/court.dart` and add:

```dart
import 'package:flutter/material.dart';

class Court {
  final String id;
  final String name;
  final String sport;
  final String location;
  final String description;
  final IconData icon;
  final List<String> availableSlots;

  const Court({
    required this.id,
    required this.name,
    required this.sport,
    required this.location,
    required this.description,
    required this.icon,
    required this.availableSlots,
  });
}
```

### What's going on here:
* `import 'package:flutter/material.dart';`: Needed because `IconData` comes from Flutter's graphics library.
* The constructor has curly braces `{ ... }`. In Dart, this makes parameters **named**. Instead of having to remember the exact order of seven arguments, you pass them by name: `Court(id: '1', name: 'Tennis', ...)`.
* `required this.name`: Tells Dart that whoever creates a `Court` **must** provide a name. If they forget, the compiler flags it before the app even runs.

---

## Step 2 - Create `lib/models/booking.dart`

Now let's build the model that represents a reservation made by a student.

Inside `lib/models/`, create `booking.dart`:

```text
lib/
└── models/
    ├── court.dart
    └── booking.dart
```

Open `lib/models/booking.dart` and write:

```dart
class Booking {
  final String id;
  final String courtId;
  final String courtName;
  final String sport;
  final DateTime date;
  final String timeSlot;
  final String status;

  Booking({
    required this.id,
    required this.courtId,
    required this.courtName,
    required this.sport,
    required this.date,
    required this.timeSlot,
    this.status = 'Confirmed',
  });
}
```

### Look closely at `status`:
Notice that `status` does not have `required`. Instead, it has a default value: `this.status = 'Confirmed'`.
If you pass a status when creating a booking, Dart uses it. If you don't, Dart sets it to `'Confirmed'` for you.

---

## Step 3 - Check Your Code with `flutter analyze`

These model files don't render anything visual on screen yet, so your app UI won't change.
Let's run Flutter's static analyzer to verify our syntax has zero typos.

In your terminal:

```bash
flutter analyze
```

---

## What You Should See

```text
Analyzing court_booker...
No issues found! (ran in 0.9s)
```

If it says `No issues found!`, your blueprints are solid.

---

## Gotchas & Fixes

### 1. `Undefined class 'IconData'`
* **What happened**: Missing `import 'package:flutter/material.dart';` at the top of `court.dart`.
* **The fix**: Make sure the import is on line 1 of `court.dart`.

### 2. Missing commas inside the constructor
* **What happened**: Forgetting commas between named parameters.
* **The fix**: Inside `{ required this.id, required this.name, ... }`, end every parameter with a comma `,`.

### 3. File in the wrong directory
* **What happened**: Saving `court.dart` directly in `lib/` instead of `lib/models/`.
* **The fix**: Check your file tree. The path must be `lib/models/court.dart`.

---

## Checkpoint

Move to Step 04 once:

- [ ] `lib/models/court.dart` exists with zero errors.
- [ ] `lib/models/booking.dart` exists with zero errors.
- [ ] You can explain what a class is and how an object is created from it.
- [ ] `flutter analyze` reports `No issues found!`.

---

## What You Learned

* A **Class** is a blueprint; an **Object** is an instance stamped from it.
* `final` protects properties from accidental modification.
* `List<String>` is an ordered collection containing only text strings.
* Named parameters in constructors (`{ required this.x }`) make code readable and safe.
* Default parameter values provide clean fallbacks when arguments are omitted.

Next: [Step 04 - Create the Sample Data & Helpers](04-create-the-sample-data.md)
