# Step 14: Architecture & Verification

## What You Just Built

Take a second to step back and look at what you have created. You started with an empty file in an empty folder. Now, you have a complete, multi-screen campus sports facility reservation app running right in front of you.

Along the way, you did not just copy-paste snippets. You learned real software engineering concepts:
* **Dart fundamentals:** classes, objects, constructors, null safety, lists, and asynchronous functions.
* **Flutter UI design:** Material 3 theming, card components, layouts, dialogs, and snackbars.
* **State architecture:** unidirectional data flow, reactive notification badges, and in-memory lifecycle management.
* **Code quality:** accessibility guidelines and automated widget testing.

---

## Final Project Architecture

Here is how all the pieces in `lib/` fit together. Every file has one clear job:

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

---

## File Responsibility Breakdown

| File | Component Type | Primary Responsibility |
| :--- | :--- | :--- |
| `lib/main.dart` | Application Bootstrap | Configures the entry point, root `MaterialApp`, and global Material 3 athletic forest green theme (`#1E6F5C`). |
| `lib/models/court.dart` | Data Model | Blueprint defining sports facility properties (name, sport, location, slots, icon). |
| `lib/models/booking.dart` | Data Model | Blueprint defining a confirmed reservation (timestamps, court info, status). |
| `lib/data/sample_data.dart` | Data Store & Helpers | Holds `sampleCourts` inventory, mutable `sessionBookings` list, and `formatDate()`. |
| `lib/screens/home_screen.dart` | Root Screen | Displays welcome banner, facility catalog, and live `AppBar` reservation counter badge. |
| `lib/screens/court_details_screen.dart` | Form & Detail View | Manages date picking (`showDatePicker`), time-slot selection, and reservation confirmation modal. |
| `lib/screens/bookings_screen.dart` | Management View | Displays confirmed bookings, deletion safeguard dialog, and welcoming empty states. |
| `lib/widgets/court_card.dart` | Reusable Component | Renders venue card with sport pill, location pin, description preview, and book action. |
| `lib/widgets/booking_card.dart` | Reusable Component | Renders reservation card with formatted date/time stamps and cancellation action. |

---

## The Complete CRUD Lifecycle in Court Booker

Almost every app you use every day, from Instagram to your favorite food delivery app, revolves around four basic operations called **CRUD**:

* **C**reate: Adding new information.
* **R**ead: Viewing existing information.
* **U**pdate: Modifying existing information.
* **D**elete: Removing information.

Here is how Court Booker implements all four:

```text
+-------------------+-----------------------------------------+---------------------------------+
| Operation         | Where It Happens in Court Booker        | Exact Dart Code                 |
+-------------------+-----------------------------------------+---------------------------------+
| **Create**        | Court Details -> Confirm Booking Modal  | sessionBookings.add(...)        |
| **Read**          | Home Screen, Details Screen, Bookings   | sampleCourts.map(...)           |
|                   |                                         | ListView.builder(...)           |
| **Update**        | Changing Date or Selecting Time Slot    | setState(() { slot = ... })     |
| **Delete**        | My Bookings -> Cancel Safeguard Dialog  | sessionBookings.removeWhere(...) |
+-------------------+-----------------------------------------+---------------------------------+
```

---

## How Data Moves Through the App (Data Flow)

Understanding how data flows between screens is the key to mastering Flutter:

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

1. **`HomeScreen`** reads courts from `sampleCourts` and counts reservations from `sessionBookings`.
2. When the user taps a card, **`Navigator.push`** opens **`CourtDetailsScreen`**, passing the selected `Court` object forward.
3. The user picks a date and slot. Tapping **Confirm** creates a new `Booking` object and adds it to `sessionBookings`.
4. The user is redirected to **`BookingsScreen`** via **`Navigator.pushReplacement`**.
5. Canceling a booking prompts an alert dialog. Confirming calls `removeWhere()` and updates the UI with `setState()`.
6. Popping back to **`HomeScreen`** updates the bookmark counter badge automatically because we use `await Navigator.push()` and refresh on return.

---

## Automated Verification Commands

In your project terminal, run these three standard commands to verify your app:

### 1. Code Formatting
```bash
dart format lib test
```
Ensures every file strictly matches the official Dart formatting guidelines.

### 2. Static Code Analysis
```bash
flutter analyze
```
Verifies there are zero syntax errors, zero missing imports, and zero dead code warnings:
```text
Analyzing court_booker...
No issues found! (ran in 0.8s)
```

### 3. Automated Test Suite
```bash
flutter test
```
Executes the automated widget and accessibility test suite in `test/widget_test.dart`:
```text
00:00 +0: Renders home screen with title, welcome banner, and sample courts
00:00 +1: Navigates to court details, selects slot, confirms booking, and displays in My Bookings
00:00 +2: Can cancel a booking and display the empty state
00:00 +3: Meets accessibility tap target and labeling guidelines on Home screen
00:00 +4: All tests passed!
```

---

## Complete Manual Testing Checklist

Run `flutter run` and check off each feature live on your device or simulator:

### 1. Home Screen & Venue Inventory
- [ ] Top `AppBar` displays the tennis icon and "Court Booker".
- [ ] Gradient hero card reads: "Find & Book Sports Courts".
- [ ] Four venues are displayed: Central Sports Arena, Indoor Basketball Court, Tennis Court 01, Squash Studio North.
- [ ] Each card shows its distinctive sport badge, location pin, description, and available slot count.

### 2. Court Details & Date Picking
- [ ] Tapping any court opens its dedicated details screen with a custom header card.
- [ ] The date card defaults to today's date formatted cleanly (e.g., `Thu, Sep 24, 2026`).
- [ ] Tapping **Change** opens the calendar modal.
- [ ] Past dates are disabled; selecting a future date updates the display instantly.

### 3. Slot Selection & Validation Gate
- [ ] Available slots appear as neat rounded chips.
- [ ] Before selecting a slot, an info label reads *"Please select a time slot to continue."*
- [ ] The **Review & Confirm Booking** button is disabled until a slot is selected.
- [ ] Tapping a slot highlights it in green and displays a checkmark (`Icons.check_circle_rounded`).
- [ ] Tapping the selected slot again toggles it off and disables the button.

### 4. Booking Confirmation Modal
- [ ] Tapping **Review & Confirm Booking** displays the `AlertDialog`.
- [ ] The dialog clearly displays the court name, date, and time slot.
- [ ] Tapping **Cancel** dismisses the dialog with no changes.
- [ ] Tapping **Confirm Booking** shows a floating SnackBar and redirects to "My Bookings".

### 5. My Bookings & Badge Count
- [ ] The newly booked court appears in "My Bookings" with a green `(✅) Confirmed` badge.
- [ ] Pressing the back button returns to `HomeScreen`.
- [ ] The bookmark icon in the top-right now shows a notification badge with the number `1`!

### 6. Cancellation & Empty State
- [ ] Navigating to "My Bookings" and tapping **Cancel Booking** prompts a confirmation dialog.
- [ ] Tapping **Keep Booking** preserves the reservation.
- [ ] Tapping **Cancel Booking** removes the reservation and shows a cancellation SnackBar.
- [ ] When all bookings are removed, the screen transitions to the **Empty State** with the "Browse Courts" button.
- [ ] Returning to `HomeScreen` clears the `AppBar` badge.

---

## 15 Questions Every Flutter Beginner Should Be Able to Answer

Can you explain these 15 fundamental concepts to a friend?

1. **What is a Flutter Widget?**
   The basic visual building block of a Flutter user interface. Everything on screen (text, button, image, layout padding) is a widget. Think of widgets like LEGO bricks.
2. **What is the Widget Tree?**
   The hierarchy of nested widgets that describes how your user interface is assembled.
3. **What is a Class vs. an Object?**
   A class is a blueprint (the cookie cutter); an object is an individual instance created from that blueprint (the actual cookie).
4. **What is a Constructor?**
   A special method used to create and configure an object from a class blueprint.
5. **What is the difference between `StatelessWidget` and `StatefulWidget`?**
   A `StatelessWidget` is like a printed photograph: once created, its appearance never changes. A `StatefulWidget` is like a digital clock: it holds mutable data that can change over time.
6. **What is State?**
   The active data in memory that determines what is currently drawn on the screen.
7. **Why do we call `setState()`?**
   To tell Flutter that internal data has changed, prompting it to call `build()` and redraw the interface with the fresh values.
8. **What is `BuildContext`?**
   A handle that tells a widget where it sits inside the overall Widget Tree.
9. **Why is `ListView.builder` more efficient than `ListView`?**
   It works like a sushi conveyor belt: it only builds list rows when they scroll onto the screen and recycles them when they scroll off, saving memory.
10. **How does the Navigation Stack work (`push` vs `pop` vs `pushReplacement`)?**
    Think of a deck of cards:
    * `push`: Places a new card on top of the deck.
    * `pop`: Removes the top card to reveal the previous one.
    * `pushReplacement`: Swaps the top card with a new one so pressing back skips the old screen.
11. **What is asynchronous programming (`Future`, `async`, `await`)?**
    A way to handle operations that take time to complete (like waiting for a user to pick a date from a calendar) without freezing the app. It works like a vibrating buzzer at a coffee shop.
12. **What is Null Safety (`?` and `!`)?**
    A system that prevents empty-value crashes. `?` marks an empty box (a variable that might be null), while `!` tells Dart you promise the box is not empty.
13. **What is a `VoidCallback`?**
    A function that takes no parameters and returns nothing, commonly used for button tap event handlers.
14. **What is an Empty State?**
    A friendly screen shown when a list has no data yet, reassuring the user and pointing them toward their next action.
15. **What is CRUD?**
    Create, Read, Update, and Delete: the four core data operations that power almost every application.

---

## What Can You Build Next?

Now that you have built Court Booker, here are fun ways to expand it:
* **Add New Sports:** Add Swimming Pools, Volleyball, or Table Tennis to `sampleCourts` in `lib/data/sample_data.dart`.
* **Personalize Themes:** Experiment with different seed colors in `lib/main.dart` (try `Colors.indigo` or `Colors.teal`).
* **Cloud Persistence:** Connect `sessionBookings` to Google Cloud Firestore using `collection('bookings').add(...)` to sync reservations across multiple phones in real time!

Congratulations on completing the **GDSC Flutter App Development Workshop 2026**! 🎉🎾
