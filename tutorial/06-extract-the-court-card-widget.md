# Step 06 - Extract the Court Card Widget

## What We're Building

In this step, we will create our first standalone UI component: **`CourtCard`** in `lib/widgets/court_card.dart`. Then we'll use it on `HomeScreen` to render all four venues from `sampleCourts`.

Each card includes:
* An icon container colored with the court's sport symbol
* The venue name and a sport pill badge (Badminton, Basketball, Tennis, Squash)
* A campus location row with a pin icon
* A two-line description preview that truncates cleanly if the text is long
* A bottom action bar showing slot availability and a **Book Court** button
* Accessibility tags for screen readers

```text
+-------------------------------------------------------+
|  [🎾]  Central Sports Arena                           |
|        [ Badminton ]                                  |
|                                                       |
|  📍 Main Campus, Building A                           |
|  Indoor air-conditioned wooden court with...          |
|                                                       |
|  5 slots available               [ 📅 Book Court ]    |
+-------------------------------------------------------+
```

---

## What You'll Learn

* Why developers break code into **reusable widgets** instead of writing massive 500-line files
* What a **`VoidCallback`** is and how to pass actions into child widgets
* How **`InkWell`** provides visual ripple animations on tap
* How to avoid broken text layouts using **`maxLines`** and **`TextOverflow.ellipsis`**
* What **`Semantics`** does for blind and low-vision users
* How the **spread operator (`...`)** and **`.map()`** convert data into widgets

---

## Programming Concepts for Complete Beginners

### 1. Why Extract Widgets?

Imagine you have four courts to show. You could copy-paste 80 lines of card code four times inside `home_screen.dart`. That's over 300 lines of repetitive code.
If you decide to change the border radius tomorrow, you'd have to track down four different places.

By extracting `CourtCard` into its own file:
1. You design the layout **once** in `lib/widgets/court_card.dart`.
2. You pass in whatever `Court` data you want to display.
3. Your `home_screen.dart` stays short, clean, and readable:
   ```dart
   ...sampleCourts.map((court) => CourtCard(court: court, onTap: ...))
   ```

### 2. Passing Actions with `VoidCallback`
In Dart, **functions can be passed as variables**, just like strings or integers.
A `VoidCallback` is simply a variable holding a function that takes zero inputs and returns nothing: `void Function()`.
When we declare:
```dart
final VoidCallback onTap;
```
We tell the card: *"You don't need to know what screen to open. Just let your parent know whenever a student taps you, and the parent will take care of the rest."*

### 3. What does `...` (The Spread Operator) Do?
Normally, `sampleCourts.map(...)` returns an `Iterable` (a list-like collection). But `ListView`'s `children:` expects individual widgets, not a list inside a list.
The three dots `...` "unpack" each card directly into the children array.

---

## Step 1 - Create `lib/widgets/court_card.dart`

In your editor, create a new folder named `widgets` inside `lib/`.

Inside `lib/widgets/`, create `court_card.dart`:

```text
lib/
└── widgets/
    └── court_card.dart
```

---

## Step 2 - Build `CourtCard`

Open `lib/widgets/court_card.dart` and add the full widget:

```dart
import 'package:flutter/material.dart';
import '../models/court.dart';

class CourtCard extends StatelessWidget {
  final Court court;
  final VoidCallback onTap;

  const CourtCard({
    super.key,
    required this.court,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Semantics(
      button: true,
      label: '${court.name}, ${court.sport}, located at ${court.location}',
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        elevation: 0,
        color: colorScheme.surface,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        court.icon,
                        color: colorScheme.onPrimaryContainer,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            court.name,
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
                              court.sport,
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
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        court.location,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  court.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${court.availableSlots.length} slots available',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: onTap,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(120, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.calendar_month, size: 18),
                      label: const Text('Book Court'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## Step 3 - Render `CourtCard` on `HomeScreen`

Now let's wire these cards into `lib/screens/home_screen.dart`.

Open `lib/screens/home_screen.dart`:
1. Add the import for `court_card.dart` at the top:
   ```dart
   import '../widgets/court_card.dart';
   ```
2. Add a temporary handler `_openCourtDetails(Court court)` inside `_HomeScreenState`:
   ```dart
   void _openCourtDetails(Court court) {
     // We will connect real page navigation in Step 07!
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text('Selected: ${court.name}'),
         duration: const Duration(seconds: 1),
       ),
     );
   }
   ```
3. Inside the `ListView`'s `children`, spread the list of court cards at the bottom:
   ```dart
   // Court Cards
   ...sampleCourts.map(
     (court) => CourtCard(
       court: court,
       onTap: () => _openCourtDetails(court),
     ),
   ),
   ```

Here is your updated `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import '../models/court.dart';
import '../data/sample_data.dart';
import '../widgets/court_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openCourtDetails(Court court) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: ${court.name}'),
        duration: const Duration(seconds: 1),
      ),
    );
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

Save both files. Press **`r`** in your terminal for Hot Reload.

---

## What You Should See

Look at your screen:
1. Four clean cards appear under the header:
   * **Central Sports Arena** (Badminton)
   * **Indoor Basketball Court** (Basketball)
   * **Tennis Court 01** (Tennis)
   * **Squash Studio North** (Squash)
2. Each card shows its custom sport icon, location pin, description snippet, and slot count.
3. Tap anywhere on a card or its **Book Court** button. A quick SnackBar pops up confirming: *"Selected: Central Sports Arena"*.
4. Notice the clean ink ripple animation when your finger or cursor touches the card.

---

## Checkpoint

Move to Step 07 once:

- [ ] `lib/widgets/court_card.dart` passes `flutter analyze`.
- [ ] `HomeScreen` displays all four cards.
- [ ] Tapping any card or button triggers the SnackBar confirmation.
- [ ] Text descriptions wrap cleanly onto two lines without overflowing.

---

## What You Learned

* Extracting reusable widgets keeps code modular and maintainable.
* `VoidCallback` lets child components report clicks back up to their parent.
* `InkWell` provides Material touch ripples.
* `Semantics` makes your app accessible to users on screen readers.
* `...list.map(...)` maps raw data objects into widgets on the fly.

Next: [Step 07 - Add Navigation & AppBar Badge](07-add-navigation-and-app-badge.md)
