# Step 07 - Add Navigation & AppBar Badge

## What We're Building

In this step, we will connect our screens together using Flutter's **`Navigator`** and add a live notification **`Badge`** to the home screen's `AppBar`.

Here is the goal:
1. Tapping any court card slides open the details screen for that facility.
2. Tapping the bookmark icon in the top-right corner opens "My Bookings."
3. Whenever `sessionBookings` has reservations in it, an active count badge (like `1` or `2`) appears directly over the bookmark icon.
4. When you come back to the home screen, `setState()` automatically repaints the badge with the latest count.

```text
               +-----------------------------+
               |         HomeScreen          |
               | (Live Reservation Badge: 1) |
               +--------------+--------------+
                              |
        +---------------------+---------------------+
        |                                           |
        | Navigator.push                            | Navigator.push
        v                                           v
+-----------------------+                   +-----------------------+
|  CourtDetailsScreen   |                   |    BookingsScreen     |
| (Selected Court Info) |                   |  (Active User Slots)  |
+-----------------------+                   +-----------------------+
```

---

## What You'll Learn

* How Flutter routes work using a **Stack** (the deck of cards analogy)
* How to use **`Navigator.push()`** and **`MaterialPageRoute`**
* How to pass an object (`Court`) into a new screen's constructor
* What **`async`** and **`await`** mean in plain terms
* How to use Material 3's **`Badge.count`** widget on an icon button
* Why awaiting a navigation route lets you refresh state when returning

---

## Programming Concepts for Complete Beginners

### 1. The Navigation Stack (Deck of Cards Analogy)

In mobile operating systems, screens are managed like a **deck of cards**:

```text
+-----------------------+
|  Top Card: Details    |  <-- What the user currently sees
+-----------------------+
|  Bottom Card: Home    |  <-- Sitting underneath, waiting
+-----------------------+
```

* **`Navigator.push()`**: Places a new card on top of the deck. The new screen slides into view.
* **`Navigator.pop()`**: Removes the top card. The screen slides away, revealing whatever was sitting underneath.

Flutter handles the top-left **back arrow** automatically. Whenever there is more than one card on the stack, the `AppBar` draws a back button that calls `Navigator.pop()`.

### 2. Passing Data Between Screens
How does `CourtDetailsScreen` know which court you tapped? Through its **constructor**:
```dart
CourtDetailsScreen(court: court)
```
The home screen hands the selected `Court` object directly to the new screen when creating it.

### 3. Why `await Navigator.push()`?
When a student taps a court card, we write:
```dart
await Navigator.push(...);
setState(() {});
```
* `await` tells Dart: *"Pause right here. Wait until the user finishes on the next screen and pops back."*
* Once they tap the back arrow, the code wakes up and calls `setState(() {})`. That triggers `HomeScreen` to rebuild and update the badge count.

---

## Step 1 - Create a Starter Stub for `CourtDetailsScreen`

Before we can navigate to the details screen, the file needs to exist.

Inside `lib/screens/`, create `court_details_screen.dart`:

```text
lib/
└── screens/
    └── court_details_screen.dart
```

Open `lib/screens/court_details_screen.dart` and add this starter stub:

```dart
import 'package:flutter/material.dart';
import '../models/court.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.court.name),
      ),
      body: Center(
        child: Text('Details for ${widget.court.name} coming soon!'),
      ),
    );
  }
}
```

---

## Step 2 - Create a Starter Stub for `BookingsScreen`

Inside `lib/screens/`, create `bookings_screen.dart`:

```text
lib/
└── screens/
    └── bookings_screen.dart
```

Open `lib/screens/bookings_screen.dart` and add this starter stub:

```dart
import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: const Center(
        child: Text('Your bookings will appear here!'),
      ),
    );
  }
}
```

---

## Step 3 - Wire Navigation & Badge in `HomeScreen`

Open `lib/screens/home_screen.dart`.

We will make three targeted updates:
1. Import both screens at the top:
   ```dart
   import 'court_details_screen.dart';
   import 'bookings_screen.dart';
   ```
2. Replace `_openCourtDetails` and add `_openMyBookings` with `async/await`:
   ```dart
   void _openCourtDetails(Court court) async {
     await Navigator.push(
       context,
       MaterialPageRoute(
         builder: (_) => CourtDetailsScreen(court: court),
       ),
     );
     // Refresh to update the bookings count in the AppBar badge
     setState(() {});
   }

   void _openMyBookings() async {
     await Navigator.push(
       context,
       MaterialPageRoute(
         builder: (_) => const BookingsScreen(),
       ),
     );
     // Refresh to update the bookings count in the AppBar badge
     setState(() {});
   }
   ```
3. Add the `actions:` list to the `AppBar` using `Badge.count`:
   ```dart
   actions: [
     IconButton(
       tooltip: 'My Bookings',
       icon: Badge.count(
         count: sessionBookings.length,
         isLabelVisible: sessionBookings.isNotEmpty,
         child: const Icon(Icons.bookmark_outline),
       ),
       onPressed: _openMyBookings,
     ),
   ],
   ```

Here is the complete `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import '../models/court.dart';
import '../data/sample_data.dart';
import '../widgets/court_card.dart';
import 'court_details_screen.dart';
import 'bookings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openCourtDetails(Court court) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourtDetailsScreen(court: court),
      ),
    );
    // Refresh to update the bookings count in the AppBar badge
    setState(() {});
  }

  void _openMyBookings() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BookingsScreen(),
      ),
    );
    // Refresh to update the bookings count in the AppBar badge
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.sports_tennis_rounded,
              color: colorScheme.primary,
              size: 26,
            ),
            const SizedBox(width: 8),
            const Text(
              'Court Booker',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'My Bookings',
            icon: Badge.count(
              count: sessionBookings.length,
              isLabelVisible: sessionBookings.isNotEmpty,
              child: const Icon(Icons.bookmark_outline),
            ),
            onPressed: _openMyBookings,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // Hero / Welcome Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primaryContainer,
                    colorScheme.secondaryContainer.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find & Book Sports Courts',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Choose a court and reserve your time.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Available Courts Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Courts',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${sampleCourts.length} courts',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Court Cards
          ...sampleCourts.map(
            (court) => CourtCard(
              court: court,
              onTap: () => _openCourtDetails(court),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## Run the App

Save all three files. In your terminal, hit **`r`** for Hot Reload.

---

## What You Should See

1. Look at the top right of the `AppBar`: a **bookmark icon** `[🔖]` is now visible.
2. Because `sessionBookings` is currently empty, no badge number is drawn (`isLabelVisible: sessionBookings.isNotEmpty`).
3. Tap on **Central Sports Arena** or its "Book Court" button:
   * A new screen slides into view.
   * The AppBar title reads **Central Sports Arena**.
   * An automatic back arrow appears in the top-left corner.
4. Tap that back arrow:
   * You return cleanly to the home screen.
5. Tap the bookmark icon in the top right:
   * The "My Bookings" screen opens up.

---

## Checkpoint

You can move to Step 08 once:

- [ ] `CourtDetailsScreen` and `BookingsScreen` compile without errors.
- [ ] Tapping any court opens the details screen with that court's title.
- [ ] Tapping the back arrow returns to `HomeScreen`.
- [ ] Tapping the bookmark icon opens `BookingsScreen`.

---

## What You Learned

* Flutter organizes screens into a **Navigation Stack**.
* `Navigator.push()` pushes a new screen on top; the back button pops it off.
* `MaterialPageRoute` handles smooth page transitions.
* You pass data between screens through constructor arguments (`CourtDetailsScreen(court: court)`).
* `Badge.count` displays notification numbers directly over icons.
* `await Navigator.push()` combined with `setState()` lets parent pages update when coming back from a sub-screen.

Next: [Step 08 - Build the Court Details Screen](08-build-the-court-details-screen.md)
