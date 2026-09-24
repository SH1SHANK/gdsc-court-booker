# Step 10 - Build Interactive Slot Chips

## What We're Building

In this step, we will build the time-slot chip selector and validation gate on `CourtDetailsScreen`.

Here is how it works:
* A responsive multi-row grid of time-slot chips using Flutter's **`Wrap`** widget
* Toggle selection: Tapping a slot selects it; tapping it again deselects it
* **Dual-Coded Accessibility**: Selected chips switch to a solid green background AND swap their clock icon for a checkmark (`Icons.check_circle_rounded`)
* **Validation Gate**: If no slot is picked, a helper hint appears and the "Review & Confirm Booking" button is **disabled** (`onPressed: null`). The moment you tap a slot, the button lights up

```text
Available Time Slots
Select a preferred time slot for your session

+------------------+  +------------------+  +------------------+
| (🕒) 09:00 AM    |  | (✅) 10:00 AM    |  | (🕒) 11:00 AM    |
+------------------+  +------------------+  +------------------+
                      (Selected: Forest Green)

+------------------+  +------------------+
| (🕒) 04:00 PM    |  | (🕒) 05:00 PM    |
+------------------+  +------------------+

[ ✅ Review & Confirm Booking ]  <-- Button is ENABLED only when slot is picked!
```

---

## What You'll Learn

* How the **`Wrap`** widget automatically flows chips across multiple lines
* How the **ternary operator** (`condition ? a : b`) keeps conditional styling readable
* How to disable any button in Flutter simply by passing **`null`** to `onPressed`
* Why **dual-coded visual design** (color + icon) matters for colorblind users
* How to enforce the mobile standard **48x48 dp touch target**

---

## Programming Concepts for Complete Beginners

### 1. What is the `Wrap` Widget?
If you put five chips inside a standard `Row`, and the phone screen is only wide enough for three, the remaining two will spill off the edge and throw a layout error.
A **`Wrap`** widget solves this. It acts like a row that wraps to the next line whenever it runs out of horizontal room:
* `spacing: 10`: The horizontal gap between chips on the same line.
* `runSpacing: 10`: The vertical gap between lines of chips.

### 2. The Ternary Operator (`condition ? ifTrue : ifFalse`)
Instead of writing an entire five-line `if/else` block just to pick a color, Dart gives you a shorthand called the **ternary operator**:
```dart
color: isSelected ? Colors.green : Colors.grey
```
Read it like a question: *"Is it selected? If YES, use green. If NO, use grey."*

### 3. How to Disable a Button with `null`
How do you make a button greyed out and unclickable in Flutter?
**Set its `onPressed` parameter to `null`:**
```dart
onPressed: selectedSlot == null ? null : _showConfirmationDialog
```
When `onPressed` is `null`, Flutter automatically dims the button colors and ignores all taps. No extra "isDisabled" flags required.

### 4. Dual-Coded Visual States for Accessibility
Around 8% of men and 0.5% of women have color vision deficiency. If your app only changes a chip's color from grey to green, a colorblind user might not be able to tell what's selected.
By combining a color change **with an explicit checkmark icon** (`Icons.check_circle_rounded`), your interface is unmistakable for every student.

---

## Step 1 - Add the Time Slots and Action Button to the UI

Open `lib/screens/court_details_screen.dart`.

Locate the `Column`'s `children` inside `build()`. Directly below the Date Selection card added in Step 09, add:

```dart
            const SizedBox(height: 24),

            // Time Slot Selection Section
            Text(
              'Available Time Slots',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Select a preferred time slot for your session',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.court.availableSlots.map((slot) {
                final isSelected = selectedSlot == slot;

                return Semantics(
                  button: true,
                  selected: isSelected,
                  label: 'Time slot $slot${isSelected ? ", selected" : ""}',
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        // Toggle selection: deselect if tapped again, otherwise select
                        selectedSlot = isSelected ? null : slot;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 48),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.outline.withValues(alpha: 0.4),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected
                                ? Icons.check_circle_rounded
                                : Icons.access_time,
                            size: 18,
                            color: isSelected
                                ? colorScheme.onPrimary
                                : colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            slot,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Booking Action & Validation Info
            if (selectedSlot == null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Please select a time slot to continue.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: selectedSlot == null ? null : _showConfirmationDialog,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  'Review & Confirm Booking',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
```

---

## Step 2 - Add a Stub for `_showConfirmationDialog`

Because `onPressed` references `_showConfirmationDialog`, add this quick placeholder inside `_CourtDetailsScreenState`:

```dart
  void _showConfirmationDialog() {
    // We will build the full confirmation modal in Step 11!
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected slot: $selectedSlot for ${formatDate(selectedDate)}'),
      ),
    );
  }
```

---

## Run the App

Save `court_details_screen.dart`. Press **`r`** for Hot Reload.

---

## What You Should See

1. Open any court details screen (like **Central Sports Arena**).
2. Scroll down past the date card:
   * The **Available Time Slots** section appears.
   * Five time chips wrap neatly across the width.
3. Look at the bottom button:
   * It's greyed out and unclickable.
   * Right above it sits the reminder: *"Please select a time slot to continue."*
4. Tap **"09:00 AM"**:
   * The chip fills with deep forest green.
   * Its clock icon swaps to a white checkmark `(✅)`.
   * The info warning vanishes.
   * The **Review & Confirm Booking** button activates in solid green.
5. Tap **"09:00 AM"** again:
   * It toggles off.
   * The button disables itself immediately.
6. Tap **"10:00 AM"** and tap **Review & Confirm Booking**:
   * A SnackBar confirms: *"Selected slot: 10:00 AM for Thu, Sep 24, 2026"*.

---

## Common Mistakes

### 1. Using `Row` instead of `Wrap`
* **The mistake**: Placing all time slot chips inside a single horizontal `Row`.
* **What you see**: A screen overflow crash with a yellow-and-black striped banner: `A RenderFlex overflowed by 142 pixels on the right`.
* **The fix**: Use `Wrap` with `spacing` and `runSpacing`. `Wrap` automatically moves chips to the next line when screen width runs out.

### 2. Passing `() {}` instead of `null` to disable a button
* **The mistake**: Writing `onPressed: isSlotSelected ? () => _proceed() : () {}`.
* **What you see**: The button remains styled as active and clickable, even when no slot has been chosen.
* **The fix**: In Flutter, a button is disabled when `onPressed` is explicitly `null`: `onPressed: isSlotSelected ? () => _proceed() : null`.

### 3. Missing toggle-to-deselect logic
* **The mistake**: Simply writing `selectedSlot = slot;` inside the chip's `onTap`.
* **What you see**: Tapping a slot selects it, but tapping it a second time does nothing; the user has no way to deselect.
* **The fix**: Use a ternary check: `selectedSlot = isSelected ? null : slot;`. If it's already selected, set it back to `null`.

### 4. Hardcoding slot lists in the screen
* **The mistake**: Re-typing `['09:00 AM', '10:00 AM', ...]` inside `_CourtDetailsScreenState` instead of using `widget.court.availableSlots`.
* **What you see**: Every court shows the exact same schedule regardless of its actual facility data.
* **The fix**: Always iterate over `widget.court.availableSlots.map(...)` so each venue displays its own unique timetable.

---

## Checkpoint

You can move to Step 11 once:

- [ ] All court time slots render in a responsive wrapped grid.
- [ ] Tapping a slot highlights it and displays the checkmark icon.
- [ ] Tapping a selected slot deselects it.
- [ ] The action button stays disabled whenever `selectedSlot == null`.
- [ ] Selecting a slot enables the button.

---

## What You Learned

* `Wrap` flows items to the next line so grids don't overflow on narrow screens.
* Passing `onPressed: null` disables buttons natively in Flutter.
* Dual-coded feedback (color + icon) ensures accessibility for colorblind students.
* Conditional UI elements can be rendered using standard `if (condition)` inside a widget list.
* `BoxConstraints(minHeight: 48)` guarantees touch targets comply with accessibility guidelines.

Next: [Step 11 - Booking Confirmation Dialog](11-booking-confirmation-dialog.md)
