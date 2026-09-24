# Step 11 - Booking Confirmation Dialog

## What We're Building

In this step, we will wire up the full review modal in `CourtDetailsScreen`.

When the student taps **Review & Confirm Booking**:
1. An `AlertDialog` pops up summarizing their chosen court, date, and time slot.
2. Tapping **Cancel** dismisses the popup without changing anything.
3. Tapping **Confirm Booking**:
   * Creates a new `Booking` object stamped with the current time.
   * Appends it to `sessionBookings`.
   * Closes the dialog.
   * Pops up a floating confirmation SnackBar.
   * Replaces the details screen with **`BookingsScreen`** using `Navigator.pushReplacement()`.

```text
+-------------------------------------------------------+
|  Confirm Booking                                      |
|                                                       |
|  Please review your reservation details:              |
|  +-------------------------------------------------+  |
|  | ⚽ Court:  Central Sports Arena                 |  |
|  | 📅 Date:   Thu, Sep 24, 2026                    |  |
|  | 🕒 Time:   09:00 AM                             |  |
|  +-------------------------------------------------+  |
|                                                       |
|                     [ Cancel ]  [ Confirm Booking ]   |
+-------------------------------------------------------+
```

---

## What You'll Learn

* How to show popups using **`showDialog()`** and **`AlertDialog`**
* The crucial difference between screen **`context`** and **`dialogContext`**
* How to create unique IDs using `DateTime.now().millisecondsSinceEpoch`
* What the **null assertion operator (`!`)** does (`selectedSlot!`)
* Why **`Navigator.pushReplacement()`** is better than `push()` when completing forms
* How to trigger floating notifications with **`ScaffoldMessenger`** and **`SnackBar`**

---

## Programming Concepts for Complete Beginners

### 1. What is a Modal Dialog?
A modal dialog is a temporary card that forces the user to focus on an important confirmation. While it's open, the background dims and ignores taps.
In Flutter, `showDialog()` pushes the dialog right onto the top of the navigation stack. To close it, call:
```dart
Navigator.of(dialogContext).pop();
```

### 2. Why Two Contexts (`dialogContext` vs `context`)?
Look at the builder argument: `builder: (BuildContext dialogContext)`.
* `context`: Belongs to the underlying `CourtDetailsScreen`.
* `dialogContext`: Belongs specifically to the floating popup card.
* Calling `Navigator.of(dialogContext).pop()` closes only the **popup**.
* Keeping the names separate prevents accidental bugs where you close the wrong screen.

### 3. Generating Unique IDs with `millisecondsSinceEpoch`
In computer science, "The Epoch" is midnight on January 1, 1970.
`DateTime.now().millisecondsSinceEpoch` returns the number of milliseconds elapsed since then (a number like `1774418400000`). Because time only moves forward, this gives us a simple, zero-dependency unique ID for every reservation.

### 4. The Exclamation Point `!` (Null Assertion)
Earlier we typed `selectedSlot` as `String?` (meaning it could be null).
Before showing the modal, we made sure `selectedSlot != null`.
When we pass it to `Booking(timeSlot: selectedSlot!)`, the exclamation mark `!` tells Dart: *"I checked this myself. It is definitely not null right now. Treat it as a standard String."*

### 5. Why `pushReplacement()` Instead of `push()`?
Think about how you want the back button to behave after booking:
* If you used `Navigator.push()`: The user finishes booking and lands on "My Bookings." If they hit the back arrow, they'd land right back on the form they just submitted.
* By using **`pushReplacement()`**: Flutter removes the booking form from the stack and swaps "My Bookings" into its place. When the student hits back from "My Bookings," they return cleanly to the **Home Screen**.

---

## Step 1 - Add the Summary Row Helper

Open `lib/screens/court_details_screen.dart`.

Inside `_CourtDetailsScreenState`, add this helper above the `build()` method:

```dart
  Widget _buildSummaryRow({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
```

---

## Step 2 - Implement the Full `_showConfirmationDialog`

Replace the placeholder `_showConfirmationDialog()` in `lib/screens/court_details_screen.dart` with this implementation:

```dart
  void _showConfirmationDialog() {
    if (selectedSlot == null) return;

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        final theme = Theme.of(dialogContext);
        final colorScheme = theme.colorScheme;

        return AlertDialog(
          title: const Text('Confirm Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please review your reservation details:',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow(
                      icon: Icons.sports,
                      label: 'Court',
                      value: widget.court.name,
                      theme: theme,
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryRow(
                      icon: Icons.calendar_today,
                      label: 'Date',
                      value: formatDate(selectedDate),
                      theme: theme,
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryRow(
                      icon: Icons.access_time,
                      label: 'Time',
                      value: selectedSlot!,
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                // 1. Create the new Booking object
                final newBooking = Booking(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  courtId: widget.court.id,
                  courtName: widget.court.name,
                  sport: widget.court.sport,
                  date: selectedDate,
                  timeSlot: selectedSlot!,
                  status: 'Confirmed',
                );

                // 2. Add to session memory
                setState(() {
                  sessionBookings.add(newBooking);
                });

                // 3. Dismiss the confirmation dialog
                Navigator.of(dialogContext).pop();

                // 4. Show instant confirmation SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Booking confirmed for ${widget.court.name}!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                // 5. Replace screen with My Bookings
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const BookingsScreen()),
                );
              },
              child: const Text('Confirm Booking'),
            ),
          ],
        );
      },
    );
  }
```

---

## Run the App

Save `court_details_screen.dart`. Press **`r`** for Hot Reload.

---

## What You Should See

1. Open **Central Sports Arena**.
2. Pick a date (tomorrow, for example) and tap **"09:00 AM"**.
3. Tap **Review & Confirm Booking**:
   * The `AlertDialog` appears on a dimmed backdrop.
   * It clearly shows the court name, formatted date, and time slot.
4. Tap **Cancel**:
   * The dialog closes and you're right back on the details page.
5. Tap **Review & Confirm Booking** again, and this time hit **Confirm Booking**:
   * The popup closes.
   * A floating notification pops up at the bottom: *"Booking confirmed for Central Sports Arena!"*
   * You're redirected straight to the "My Bookings" page.
6. Tap the back button to return to the **Home Screen**:
   * Look at the top-right bookmark icon: **It now displays a badge with the number 1!**

---

## Checkpoint

You can move to Step 12 once:

- [ ] Tapping "Review & Confirm Booking" pops up the review modal.
- [ ] The dialog lists the correct court, date, and slot.
- [ ] Tapping "Cancel" closes the modal without creating a booking.
- [ ] Tapping "Confirm Booking" appends the reservation to `sessionBookings`.
- [ ] The Home Screen shows an active badge showing `1`.

---

## What You Learned

* `showDialog()` and `AlertDialog` display modal decision popups.
* `Navigator.of(dialogContext).pop()` closes the popup without popping the page underneath.
* `sessionBookings.add(...)` adds the booking directly to local memory.
* `Navigator.pushReplacement()` prevents messy back-navigation loops after submitting forms.
* Returning to `HomeScreen` triggers `setState()`, updating the `Badge.count` immediately.

Next: [Step 12 - Build the My Bookings Screen](12-build-the-my-bookings-screen.md)
