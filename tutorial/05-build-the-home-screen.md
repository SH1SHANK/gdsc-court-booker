# Step 05 - Build the Home Screen

## What We're Building

Time to build the screen students see when opening the app: **`HomeScreen`** in `lib/screens/home_screen.dart`.

We will build:
* An `AppBar` with a tennis icon and the "Court Booker" title
* A welcoming **Hero card** styled with a smooth green gradient
* A section header showing "Available Courts" alongside the live count (`4 courts`)
* Wire `HomeScreen` directly into `lib/main.dart` as the starting page

```text
+---------------------------------------+
| 🎾 Court Booker                   [🔖]|  <-- AppBar
+---------------------------------------+
| +-----------------------------------+ |
| | Find & Book Sports Courts         | |  <-- Hero Gradient Banner
| | Choose a court and reserve...     | |
| +-----------------------------------+ |
|                                       |
| Available Courts             4 courts |  <-- Section Header
|                                       |
| [ Facility Cards will go here... ]    |
+---------------------------------------+
```

---

## What You'll Learn

* The real-world difference between **`StatelessWidget`** and **`StatefulWidget`**
* What the leading underscore (`_`) means in Dart (private classes and methods)
* How **`ListView`** keeps your page scrolling smoothly without screen overflow errors
* How to style containers with **`BoxDecoration`** and **`LinearGradient`**
* How **`Column`** (vertical) and **`Row`** (horizontal) arrange content
* How to hook up a new page inside `lib/main.dart`

---

## Programming Concepts for Complete Beginners

### 1. `StatelessWidget` vs. `StatefulWidget`

Every screen in Flutter falls into one of two buckets:

| Widget Type | Analogy | When to Use It |
| :--- | :--- | :--- |
| **`StatelessWidget`** | A printed photograph | The visual layout never changes after it is drawn (icons, static labels, read-only cards). |
| **`StatefulWidget`** | A live digital clock | The screen holds data (**state**) that can change while the user is using the app. |

Why make `HomeScreen` a `StatefulWidget` right now? Because whenever a student books or cancels a court, our top app bar badge count needs to update. To refresh on the fly, the screen needs `setState()`.

### 2. Why Are There Two Classes for One StatefulWidget?
When you write a `StatefulWidget`, Flutter always asks for two classes:
1. `class HomeScreen extends StatefulWidget`: The lightweight configuration object that Flutter can recreate quickly.
2. `class _HomeScreenState extends State<HomeScreen>`: The state class where your variables and your `build()` method actually live. It stays in memory across screen rebuilds.

The leading underscore (`_`) in `_HomeScreenState` tells Dart: *"This class is private to this file. Don't let other files import it."*

### 3. Layout Essentials: Rows, Columns, and ListViews
* **`Row`**: Lays out children side-by-side horizontally: `[Item 1] [Item 2] [Item 3]`
* **`Column`**: Stacks children on top of each other vertically.
* **`ListView`**: Works like a `Column`, but it adds **scrolling**. If your content is taller than the phone's physical screen, a plain `Column` will crash into a yellow-and-black striped "RenderFlex overflowed" error. A `ListView` scrolls smoothly without complaint.

---

## Step 1 - Create `lib/screens/home_screen.dart`

In your editor, create a new folder named `screens` inside `lib/`.

Inside `lib/screens/`, create `home_screen.dart`:

```text
lib/
└── screens/
    └── home_screen.dart
```

---

## Step 2 - Build `HomeScreen`

Open `lib/screens/home_screen.dart` and add this code:

```dart
import 'package:flutter/material.dart';
import '../models/court.dart';
import '../data/sample_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        ],
      ),
    );
  }
}
```

---

## Code Breakdown

* `final theme = Theme.of(context);`: Pulls the active styling rules from `MaterialApp`.
* `final colorScheme = theme.colorScheme;`: Grabs our forest green palette (primary colors, surface shades, container tints).
* `Row(children: [Icon(...), SizedBox(width: 8), Text(...)])`: Positions the tennis racket icon next to the app title with an 8-pixel gap.
* `BoxDecoration(gradient: LinearGradient(...))`: Blends two soft green shades diagonally across the hero card.
* `MainAxisAlignment.spaceBetween`: Pushes "Available Courts" to the far left edge and "4 courts" to the far right.

---

## Step 3 - Wire `HomeScreen` into `lib/main.dart`

Now tell `lib/main.dart` to show `HomeScreen` instead of the temporary centered text.

Open `lib/main.dart` and update it:

```dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CourtBookerApp());
}

class CourtBookerApp extends StatelessWidget {
  const CourtBookerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Court Booker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E6F5C),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
```

---

## Run the App

Save both files. Press **`R`** in your running terminal for a Hot Restart.

---

## What You Should See

Look at your screen:
1. The top `AppBar` displays a green tennis racket icon followed by bold text: **Court Booker**.
2. Below that sits the hero banner with rounded corners and a soft green gradient.
3. Inside the banner, you see:
   * **Find & Book Sports Courts**
   * *Choose a court and reserve your time.*
4. Under the banner is the section title: **Available Courts** on the left, and **4 courts** on the right.

---

## Gotchas & Fixes

### 1. `The named parameter 'home' is required`
* **What happened**: Typo in the `home:` parameter of `MaterialApp`.
* **The fix**: Make sure `home: const HomeScreen(),` sits inside `MaterialApp(...)`.

### 2. Yellow and black striped overflow box
* **What happened**: Using `Column` for a long page instead of `ListView`.
* **The fix**: The body of your `Scaffold` should be a `ListView`, which enables vertical scrolling automatically.

---

## Checkpoint

You can move to Step 06 once:

- [ ] `lib/screens/home_screen.dart` exists with zero errors.
- [ ] `lib/main.dart` imports `screens/home_screen.dart` and sets `home: const HomeScreen()`.
- [ ] Hot Restart shows the top bar, gradient hero card, and "Available Courts" section title.

---

## What You Learned

* `StatefulWidget` is what you need whenever a screen must redraw when data changes.
* A leading underscore on a class name (like `_HomeScreenState`) marks it as private to that file.
* `ListView` prevents screen overflow errors by enabling scrolling.
* `LinearGradient` inside `BoxDecoration` produces clean multi-color backgrounds.
* `MainAxisAlignment.spaceBetween` separates items across the full width of a `Row`.

Next: [Step 06 - Extract the Court Card Widget](06-extract-the-court-card-widget.md)
