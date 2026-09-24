# Step 09 - Add the Interactive Date Picker

## What We're Building

In this step, we will add an interactive date card to `CourtDetailsScreen`. Students can view their selected booking date and tap **Change** to open Flutter's Material Design 3 calendar picker.

We will also enforce two university scheduling rules:
* **No past dates**: You cannot book a court yesterday (`firstDate: today`).
* **30-day window**: Reservations open at most 30 days ahead (`lastDate: today + 30 days`).

```text
+---------------------------------------+
| Choose Date                           |
| +-----------------------------------+ |
| | 📅 Selected Date                  | |
| |    Thu, Sep 24, 2026   [📅 Change]| |
| +-----------------------------------+ |
+---------------------------------------+
                   │
                   ▼ Tapping "Change"
+---------------------------------------+
|         SELECT DATE (Calendar)        |
|               September 2026          |
|    S   M   T   W   T   F   S          |
|            1   2   3   4   5          |
|    6   7   8   9  10  11  12          |
|   13  14  15  16  17  18  19          |
|   20  21  22  23 [24] 25  26          |
|   27  28  29  30                      |
|                     [CANCEL]  [OK]    |
+---------------------------------------+
```

---

## What You'll Learn

* What **asynchronous code** is and what a **`Future`** represents (the coffee buzzer analogy)
* How **`async`** and **`await`** keep your app responsive while waiting for user input
* How to trigger Flutter's calendar dialog with **`showDatePicker()`**
* How to lock down date ranges (`firstDate` and `lastDate`)
* How to guard against canceled popups with `if (picked != null)`

---

## Programming Concepts for Complete Beginners

### 1. Asynchronous Code: The Coffee Shop Buzzer

Think about ordering coffee at a busy counter:
* The barista doesn't make you freeze in place while they froth the milk.
* Instead, they hand you a **vibrating buzzer** and say: *"Grab a table. When the latte is ready, the buzzer will buzz."*

In Dart:
* That vibrating buzzer is called a **`Future`**. It's a placeholder for data that will arrive later.
* When you open a calendar picker, Dart has no idea how long the user will take to pick a date (they might tap instantly, or get distracted for a minute).
* Marking a function **`async`** and putting **`await`** before `showDatePicker()` tells Dart:
  *"Pause this specific function until the user taps a date and the buzzer rings. Keep the rest of the app running at full speed in the meantime."*

```dart
Future<void> _pickDate() async {
  // Await pauses until the user chooses a date or taps Cancel
  final DateTime? picked = await showDatePicker(...);

  if (picked != null) {
    setState(() {
      selectedDate = picked;
    });
  }
}
```

### 2. Handling Cancellation Gracefully
What if the user opens the calendar and taps **Cancel**?
`showDatePicker()` returns `null`.
That is why we check:
```dart
if (picked != null)
```
Only if they actually picked a date and tapped **OK** do we call `setState()`. If they backed out, `picked` is `null`, and we leave their previous date alone without crashing.

---

## Step 1 - Add `_pickDate` to `CourtDetailsScreen`

Open `lib/screens/court_details_screen.dart`.

Inside `_CourtDetailsScreenState`, right below `initState()`, add `_pickDate`:

```dart
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastDay = today.add(const Duration(days: 30));

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.isBefore(today) ? today : selectedDate,
      firstDate: today,
      lastDate: lastDay,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
```

### What `_pickDate` does:
* `DateTime(now.year, now.month, now.day)`: Strips out hours, minutes, and seconds so our comparison starts cleanly at midnight.
* `firstDate: today`: Disables all past calendar days.
* `lastDate: lastDay`: Disables dates beyond the 30-day window.
* `setState(() { selectedDate = picked; });`: Tells Flutter to redraw with the new date.

---

## Step 2 - Add the Date Selection Card to the UI

In `lib/screens/court_details_screen.dart`, locate the `build()` method.

Inside the `Column`'s `children`, directly below the Court Header Card, add:

```dart
            const SizedBox(height: 24),

            // Date Selection Section
            Text(
              'Choose Date',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Date',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            formatDate(selectedDate),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: _pickDate,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(110, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.edit_calendar, size: 18),
                      label: const Text('Change'),
                    ),
                  ],
                ),
              ),
            ),
```

---

## Run the App

Save `court_details_screen.dart`. Press **`r`** for Hot Reload.

---

## What You Should See

1. Open any court details screen.
2. Below the description card, you'll see the **Choose Date** box.
3. It displays today's formatted date (e.g., `Thu, Sep 24, 2026`).
4. Tap the **Change** button:
   * A Material 3 calendar modal appears on screen.
   * Past days are greyed out and unclickable.
   * Dates more than 30 days ahead are also disabled.
5. Tap a date next week and hit **OK**:
   * The calendar dismisses.
   * The card updates immediately with your chosen date.
6. Tap **Change** again, but this time hit **CANCEL**:
   * The modal closes and your previously chosen date stays right where it was.

---

## Common Mistakes

### 1. Forgetting `await` before `showDatePicker()`
* **The mistake**: Writing `final picked = showDatePicker(...);` without `await`.
* **What you see**: Dart flags a type mismatch error: `A value of type 'Future<DateTime?>' can't be assigned to a variable of type 'DateTime?'.`
* **The fix**: `showDatePicker` is asynchronous because it takes time for the human to tap a date. Mark the function `async` and add `await`: `final picked = await showDatePicker(...);`.

### 2. Setting `firstDate` after `initialDate` or `lastDate`
* **The mistake**: Setting `firstDate: DateTime(2027)` when `initialDate` is today (`2026`).
* **What you see**: Red screen crash with `Assertion failed: initialDate must be on or after firstDate`.
* **The fix**: Always ensure `firstDate <= initialDate <= lastDate`. In our app: `firstDate: now` and `lastDate: now.add(const Duration(days: 30))`.

### 3. Forgetting the `if (picked != null)` check
* **The mistake**: Writing `setState(() { selectedDate = picked!; });` directly after the picker returns.
* **What you see**: If the user taps "Cancel" or taps the dimmed background to dismiss the calendar, `picked` is `null`. The `!` operator throws a crash: `Null check operator used on a null value`.
* **The fix**: Always guard your state update with `if (picked != null) { setState(() { selectedDate = picked; }); }`.

### 4. Updating `selectedDate` outside `setState()`
* **The mistake**: Updating `selectedDate = picked;` without wrapping it in `setState()`.
* **What you see**: The calendar closes, but the card continues to show the old date because Flutter was never told to rebuild the screen.
* **The fix**: Always enclose property updates inside `setState(() { selectedDate = picked; });`.

---

## Checkpoint

You can move to Step 10 once:

- [ ] The "Choose Date" card renders formatted date text.
- [ ] Tapping "Change" pops open the calendar dialog.
- [ ] Past dates cannot be tapped.
- [ ] Picking a new date updates the card text immediately.
- [ ] Canceling the dialog preserves the existing date without errors.

---

## What You Learned

* A `Future` represents an asynchronous value that arrives later.
* `await` pauses a function until an asynchronous dialog completes.
* `showDatePicker()` provides a ready-made, accessible calendar component.
* `firstDate` and `lastDate` enforce input constraints at the UI level.
* Guarding with `if (picked != null)` keeps your app safe when users tap Cancel.

Next: [Step 10 - Build Interactive Slot Chips](10-build-interactive-slot-chips.md)
