# Step 01 - Create the Project

## What We're Building

Here in step one, we'll generate a fresh Flutter project from the command line, poke around the folders to see where things live, and get the starter counter app running on your screen.

```text
+-------------------------------------------------------+
|  Terminal: flutter create court_booker               |
|                           │                           |
|                           ▼                           |
|  Folder: court_booker/                                |
|  ├── lib/                  <-- All your code lives here|
|  │   └── main.dart                                    |
|  └── pubspec.yaml          <-- App configuration      |
|                           │                           |
|                           ▼                           |
|  Screen: Default Flutter Starter Counter App          |
+-------------------------------------------------------+
```

---

## What You'll Learn

* How **Flutter** and **Dart** fit together
* How to spin up a new project with `flutter create`
* Why almost every file you touch lives inside `lib/`
* What `pubspec.yaml` does
* How to run the project on a phone, an emulator, or your browser

---

## What Are Flutter and Dart Anyway?

If you've never touched code before, here's the two-minute mental model:
* **Dart** is the **language**. It's the vocabulary and grammar you use to tell the computer what to do (like *"save this court name"*, *"check if today is Friday"*, or *"add 1 to the count"*).
* **Flutter** is the **toolkit**. It's Google's giant library of pre-built UI components (called **widgets**). Instead of drawing every pixel of a button by hand, Flutter gives you a finished button, a ready-made text label, a scrollable list, and a top app bar.

You write your logic once in Dart, and Flutter translates it into native code that runs fast on Android, iOS, macOS, Windows, and the web.

---

## Starting Point

Open your terminal (Terminal on macOS/Linux, or PowerShell/Command Prompt on Windows).

First, check that Flutter is installed:

```bash
flutter --version
```

You should see something like:

```text
Flutter 3.47.5 • channel stable
Dart 3.13.4
```

If your terminal says `command not found`, stop here. Your system PATH doesn't know where Flutter lives yet. Ping a mentor or run through the official Flutter install guide before moving on.

---

## Step 1 - Generate the Project

Pick a folder where you want to keep your workshop projects (your `Desktop` works great):

```bash
cd ~/Desktop
```

Now run the creation command:

```bash
flutter create court_booker
```

### What Each Word Means:
* `flutter`: Runs the Flutter command-line tool.
* `create`: Tells Flutter to scaffold a complete, working starter app.
* `court_booker`: The name of your app folder. Flutter project names must be lowercase letters with underscores (`_`). We call this **snake_case**. Names like `CourtBooker` or `court-booker` will give you an error.

Flutter will create the project files and pull down standard packages. After a few seconds, you'll see:

```text
All done!
Your application code is in court_booker/lib/main.dart.
```

---

## Step 2 - Open the Folder in Your Editor

Head into the new directory:

```bash
cd court_booker
```

Now open it in VS Code (or your favorite editor):

```bash
code .
```

> **Quick Note:** The dot `.` is shorthand for "open whatever folder I'm currently in."

---

## Step 3 - The Two Folders That Actually Matter

When you open the project, the sidebar shows a bunch of files. Don't let that overwhelm you. For this workshop, **you only need to care about two items**:

```text
court_booker/
├── android/          <-- Android wrapper files (Flutter handles these)
├── ios/              <-- iOS wrapper files (Flutter handles these)
├── lib/              <-- ⭐ ALL YOUR CODE LIVES HERE!
│   └── main.dart     <-- The starting file Flutter runs first
├── macos/            <-- macOS desktop wrapper
├── test/             <-- Automated test files
├── web/              <-- Web browser wrapper
└── pubspec.yaml      <-- ⭐ Project settings and package list
```

1. **`lib/`**: Short for "library." **Every Dart file you write will live inside this folder.** When your app boots up, Flutter starts by reading `lib/main.dart`.
2. **`pubspec.yaml`**: Your app's configuration sheet. It holds the app's name, version, supported SDKs, and links to any fonts, images, or third-party packages.

You can safely ignore the platform folders (`android/`, `ios/`, etc.). Flutter generates and updates them for you.

---

## Step 4 - Launch the Starter App

Make sure you have a target device running:
* An Android emulator launched from Android Studio, OR
* The iOS Simulator (macOS only), OR
* Google Chrome.

In your editor's built-in terminal (press `` Ctrl+` `` or `` Cmd+` ``), run:

```bash
flutter run
```

If you have multiple devices connected, Flutter will print a numbered list and ask you to choose. You can also pick a target directly:

```bash
flutter run -d macos    # Runs as a desktop app on macOS
flutter run -d chrome   # Runs right in your Chrome browser
```

---

## What You Should See

After compiling, the default Flutter counter app pops up:

```text
+---------------------------------------+
|  Flutter Demo Home Page               |
+---------------------------------------+
|                                       |
|  You have pushed the button this      |
|  many times:                          |
|                                       |
|                  0                    |
|                                       |
|                                 (+)   |
+---------------------------------------+
```

* An app bar at the top titled **Flutter Demo Home Page**
* Centered helper text
* A counter showing `0`
* A floating action button with a `(+)` icon in the bottom-right corner

Click the `(+)` button a few times. The number ticks up: `1`, `2`, `3`.

> **Pro Tip:** Keep this terminal running! With Flutter, you rarely need to stop and restart. Pressing `r` in the terminal reloads your code in less than a second while keeping your app running.

---

## What Just Happened?

1. Flutter read through `lib/main.dart`.
2. It compiled that Dart code so your machine could run it directly.
3. It drew the UI components on your screen at a smooth 60 frames per second.
4. Tapping that button triggered a quick event that told Flutter to repaint the number.

In Step 02, we'll wipe out this sample counter code and build the real foundation for Court Booker!

---

## Common Mistakes

### 1. `flutter: command not found`
* **The mistake**: Your computer doesn't know where the Flutter SDK is installed.
* **The fix**: Add Flutter's `bin` directory to your shell path (`~/.zshrc` on macOS, or System Environment Variables on Windows), then restart your terminal.

### 2. Using capital letters or hyphens in project names
* **The mistake**: Running `flutter create CourtBooker` or `flutter create court-booker`. Flutter will reject this with an error: `"court-booker" is not a valid Dart package name`.
* **The fix**: Dart package names must be all lowercase with underscores (`snake_case`). Always use `flutter create court_booker`.

### 3. Running commands from the wrong directory
* **The mistake**: Running `flutter run` while sitting in your home directory or parent folder instead of inside `court_booker`. Flutter will complain: `No pubspec.yaml file found`.
* **The fix**: Type `pwd` (Mac/Linux) or `cd` (Windows) to verify your current folder. Make sure you run `cd court_booker` before launching Flutter commands.

### 4. `No connected devices found`
* **The mistake**: Running `flutter run` without an active emulator, simulator, or plugged-in phone.
* **The fix**: Launch an Android emulator or iOS simulator first, or run `flutter run -d chrome` or `flutter run -d macos` to test immediately on your desktop.

---

## Checkpoint

Move on to Step 02 once:

- [ ] `flutter create court_booker` finished without errors.
- [ ] You opened the `court_booker` folder in your code editor.
- [ ] You found `lib/main.dart` and `pubspec.yaml` in the file tree.
- [ ] The counter app is running on your screen.
- [ ] Tapping `(+)` increases the number.

---

## What You Learned

* **Dart** is the language; **Flutter** is the UI kit.
* `flutter create` builds a complete working app template.
* All your code belongs in **`lib/`**.
* `pubspec.yaml` handles app metadata and dependencies.
* `flutter run` compiles and launches the app on your screen.

Next: [Step 02 - Build the App Shell](02-build-the-app-shell.md)
