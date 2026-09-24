# Step 02 - Build the App Shell

## What We're Building

Time to wipe the default counter code clean. In this step, we will build the skeleton of **Court Booker** in `lib/main.dart`:
* An entry point function (`main`)
* Material Design 3 styling with our campus forest green theme (`#1E6F5C`)
* A starter `Scaffold` screen with a clean top `AppBar`

```text
+---------------------------------------+
| 🎾 Court Booker                       |  <-- AppBar (Material 3 Theme)
+---------------------------------------+
|                                       |
|                                       |
|      Welcome to Court Booker!         |  <-- Scaffold Body
|                                       |
|                                       |
+---------------------------------------+
```

---

## What You'll Learn

* What `void main()` does and why Dart starts reading here
* What a **widget** is (and why everything in Flutter is one)
* What a **`StatelessWidget`** is and what its `build()` method returns
* How `MaterialApp` controls universal settings like themes and titles
* How hexadecimal colors work in Flutter (`0xFF1E6F5C`)
* How `Scaffold` and `AppBar` form the frame of every phone screen
* When to use **Hot Reload** (`r`) vs **Hot Restart** (`R`)

---

## Programming Concepts for Complete Beginners

### 1. What is a Function?
A function is a named block of code that performs a job. Think of it like a recipe. When you want pancakes, you call the recipe name `makePancakes()`.

In Dart, every app starts with a special function called `main()`:
```dart
void main() {
  // Dart starts running your code right here.
}
```
* `void`: Tells Dart that this function finishes its work without returning any data back to us.
* `main()`: The universal starting point required by the Dart language.

### 2. What is a Widget?
In Flutter, **if you can see it on screen, it's a widget**.
* A line of text is a widget (`Text`).
* A button is a widget (`FilledButton`).
* An icon is a widget (`Icon`).
* Spacing between two items is a widget (`SizedBox`).
* The visual frame of the screen itself is a widget (`Scaffold`).

You build screens by nesting widgets inside other widgets, like LEGO bricks. Developers call this the **Widget Tree**.

---

## Starting Point

Make sure your app from Step 01 is running. If you closed it, open your terminal and run:

```bash
flutter run
```

---

## Step 1 - Wipe `lib/main.dart` and Import Flutter

Open `lib/main.dart` in your editor. Select everything in the file (`Ctrl+A` or `Cmd+A`) and **delete it**. You should be looking at an empty file.

At the very top of `lib/main.dart`, write this import line:

```dart
import 'package:flutter/material.dart';
```

### What this line does:
`import` lets your file use code written by other people. Importing `flutter/material.dart` pulls in Google's **Material Design** system: buttons, cards, text fields, color palettes, and layout containers.

---

## Step 2 - Add the `main()` Entry Function

Directly under your import, add:

```dart
void main() {
  runApp(const CourtBookerApp());
}
```

### Breaking this down:
* `runApp(...)`: Built-in Flutter function that takes a root widget and draws it onto your device's screen.
* `const CourtBookerApp()`: Tells Flutter to render our top-level widget. We'll define this class right now.
* `const`: Short for constant. It promises Flutter that this widget's configuration won't change while running, which helps the framework optimize rendering.

---

## Step 3 - Create the `CourtBookerApp` Root Widget

Below `main()`, add the app widget:

```dart
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Court Booker'),
        ),
        body: const Center(
          child: Text(
            'Welcome to Court Booker!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
```

---

## Line-by-Line Breakdown

Here is what is happening under the hood:

### 1. `class CourtBookerApp extends StatelessWidget`
* `class`: A blueprint for creating something in code.
* `extends StatelessWidget`: We borrow the core behavior of Flutter's `StatelessWidget`. A stateless widget never changes its own appearance after it is drawn. It has no internal mutable state.

### 2. `@override Widget build(BuildContext context)`
* Every widget must have a `build()` method.
* Flutter calls `build()` whenever it needs to draw this widget on screen.
* It must return a `Widget` (here, it returns `MaterialApp`).
* `BuildContext context`: The widget's address inside the overall tree.

### 3. `MaterialApp(...)`
The root wrapper for the entire app. It sets up:
* `title`: The app name shown in the phone's recent-apps switcher.
* `debugShowCheckedModeBanner: false`: Hides the red "DEBUG" banner from the corner.
* `theme: ThemeData(...)`: Universal styles, colors, and card shapes.

### 4. `seedColor: const Color(0xFF1E6F5C)`
* Material Design 3 uses an algorithm that takes one single **seed color** (our forest green `#1E6F5C`) and automatically generates a matching palette for surfaces, containers, buttons, and text.
* In Dart, hex colors are written as `0xFF` plus the 6 hex digits. The `FF` means 100% solid opacity (no transparency).

### 5. `Scaffold(...)`
* Just like construction scaffolding supports builders, Flutter's `Scaffold` gives you the basic slots of a mobile screen:
  * `appBar`: The top navigation bar.
  * `body`: The main area below the app bar.

---

## Run the App

Save the file.

In your terminal, press **`R`** (capital R) to trigger a **Hot Restart**.
*(Why Hot Restart instead of Hot Reload? Because we swapped out `main()` and the root widget class. A restart resets the app state and rebuilds from scratch in about one second).*

---

## What You Should See

Look at your device or emulator:
1. The old counter demo is gone.
2. The red "DEBUG" sash in the corner is gone.
3. At the top sits a clean header: **Court Booker**.
4. Right in the middle: **Welcome to Court Booker!**
5. All elements carry subtle green-tinted Material 3 styling.

---

## Common Mistakes

### 1. Missing Semicolon `;`
* **The mistake**: Forgetting the semicolon at the end of a statement, such as `runApp(const CourtBookerApp());`.
* **What you see**: Dart flags `Expected to find ';'.` with red squiggly underlines.
* **The fix**: Every statement in Dart must end with a semicolon `;`. Add `;` to the end of the line.

### 2. Missing Closing Parenthesis `)` or Bracket `}`
* **The mistake**: Leaving an open `(` or `{` without a closing counterpart when nesting widgets like `Scaffold`, `AppBar`, and `MaterialApp`.
* **What you see**: `Expected '}' to match '{'.`
* **The fix**: Put a trailing comma `,` after every closing parenthesis, then format your document (press `Shift+Option+F` on Mac or `Shift+Alt+F` on Windows). Your editor will cleanly indent each nesting level so unmatched pairs become immediately obvious.

### 3. Screen stays blank or unchanged after saving
* **The mistake**: Pressing lowercase `r` (Hot Reload) after modifying `main()` or changing the root widget class.
* **The fix**: Hot Reload updates existing widget state, but changes to `main()` require a **Hot Restart**. Press **`R`** (capital R) in your terminal to re-execute `main()` from scratch.

### 4. Forgetting the Material import
* **The mistake**: Clearing `lib/main.dart` completely but forgetting to add `import 'package:flutter/material.dart';` on line 1.
* **What you see**: Red squiggles under `StatelessWidget`, `Widget`, `BuildContext`, and `MaterialApp` with the error `Undefined class`.
* **The fix**: Always ensure `import 'package:flutter/material.dart';` sits at the very top of any UI file in Flutter.

---

## Checkpoint

You're ready for Step 03 once:

- [ ] `lib/main.dart` shows zero red error squiggles.
- [ ] Your app displays the top `AppBar` with "Court Booker".
- [ ] Centered text reads "Welcome to Court Booker!".
- [ ] The theme reflects the clean athletic green palette.

---

## What You Learned

* `void main()` is where program execution begins.
* `runApp()` draws our root widget to the physical display.
* Everything on a Flutter screen is a **Widget**.
* `MaterialApp` manages global themes and routing.
* `ColorScheme.fromSeed` creates an entire color scheme from one brand color.
* `Scaffold` gives you the default skeleton (`appBar`, `body`) for mobile screens.

Next: [Step 03 - Create the Domain Models](03-create-the-domain-models.md)
