# Step 13 - Add Cancellation Safeguard

## What We're Building

In this step, we will wire up the cancellation flow in `lib/screens/bookings_screen.dart` with an essential safety check: **confirmation before deletion**.

Accidentally brushing a "Cancel" button should never wipe out a student's reservation. Instead, your app will prompt an `AlertDialog`:
1. If the user taps **Keep Booking**, the dialog closes and the reservation stays untouched.
2. If the user taps **Cancel Booking**:
   * The booking is removed from `sessionBookings` using `.removeWhere()`.
   * The dialog closes.
   * A SnackBar confirms the cancellation.
   * If that was their last booking, the screen instantly flips to the **Empty State**.
   * Returning to the Home Screen automatically decrements or removes the badge.

```text
+-------------------------------------------------------+
|  Cancel Booking                                       |
|                                                       |
|  Are you sure you want to cancel your reservation     |
|  for Central Sports Arena on Thu, Sep 24, 2026        |
|  at 09:00 AM?                                         |
|                                                       |
|               [ Keep Booking ]  [ Cancel Booking (🔴) ]|
+-------------------------------------------------------+
```

---

## What You'll Learn

* Why destructive user actions must always be protected by a **deletion safeguard**
* How to filter and delete specific items from a Dart list using **`removeWhere()`**
* How an anonymous predicate function `(item) => item.id == booking.id` matches entries
* How `setState()` automatically swaps UI components when data conditions change

---

## Programming Concepts for Complete Beginners

### 1. What is a Deletion Safeguard?
Phones are small, and thumbs are clumsy. If you put a "Cancel" button right where someone might accidentally tap it, you will frustrate your users.
A **Safeguard Dialog** confirms intent. It pauses and asks: *"Did you really mean to do this?"*

### 2. How `.removeWhere()` Works
Suppose you have a list of bookings:
```dart
sessionBookings.removeWhere((item) => item.id == booking.id);
```
* Dart loops through every `item` in `sessionBookings`.
* The `(item) => item.id == booking.id` is a question: *"Does this item have the exact same ID as the one the user wants to cancel?"*
* If YES (`true`), Dart deletes it from the list.
* If NO (`false`), Dart leaves it alone.

Because `setState()` wraps this removal, Flutter immediately re-checks:
```dart
sessionBookings.isEmpty
```
If the list just hit zero, Flutter re-runs `build()` and draws the friendly **Empty State** right before the student's eyes. No manual page refresh needed.

---

## Step 1 - Implement `_confirmCancellation` in `BookingsScreen`

Open `lib/screens/bookings_screen.dart`.

Locate `_confirmCancellation` inside `_BookingsScreenState`. Replace the placeholder with this dialog:

```dart
  void _confirmCancellation(Booking booking) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        final theme = Theme.of(dialogContext);
        final colorScheme = theme.colorScheme;

        return AlertDialog(
          title: const Text('Cancel Booking'),
          content: Text(
            'Are you sure you want to cancel your reservation for ${booking.courtName} on ${formatDate(booking.date)} at ${booking.timeSlot}?',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Keep Booking'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              onPressed: () {
                // 1. Remove the booking matching this ID
                setState(() {
                  sessionBookings.removeWhere((item) => item.id == booking.id);
                });

                // 2. Dismiss the dialog
                Navigator.of(dialogContext).pop();

                // 3. Display feedback SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Booking for ${booking.courtName} has been cancelled.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Cancel Booking'),
            ),
          ],
        );
      },
    );
  }
```

---

## Step 2 - Verify the Complete `BookingsScreen`

Here is the entire file for `lib/screens/bookings_screen.dart` so you can check your work:

```dart
import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../data/sample_data.dart';
import '../widgets/booking_card.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  void _confirmCancellation(Booking booking) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        final theme = Theme.of(dialogContext);
        final colorScheme = theme.colorScheme;

        return AlertDialog(
          title: const Text('Cancel Booking'),
          content: Text(
            'Are you sure you want to cancel your reservation for ${booking.courtName} on ${formatDate(booking.date)} at ${booking.timeSlot}?',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Keep Booking'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              onPressed: () {
                setState(() {
                  sessionBookings.removeWhere((item) => item.id == booking.id);
                });

                Navigator.of(dialogContext).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Booking for ${booking.courtName} has been cancelled.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Cancel Booking'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: sessionBookings.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.event_available_outlined,
                        size: 52,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No Bookings Yet',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "You haven't booked a court yet.\nChoose a court and reserve your first slot.",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () {
                        // Return to the court list
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(180, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.sports_tennis),
                      label: const Text('Browse Courts'),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: sessionBookings.length,
              itemBuilder: (context, index) {
                final booking = sessionBookings[index];
                return BookingCard(
                  booking: booking,
                  onCancel: () => _confirmCancellation(booking),
                );
              },
            ),
    );
  }
}
```

---

## Run the App & Test the Full Lifecycle

Save the file and hit Hot Reload (**`r`**).

Let's test the entire reservation cycle from start to finish:

1. **Book Court 1**:
   * Open **Central Sports Arena**, pick **09:00 AM**, and tap **Confirm Booking**.
   * It shows up in "My Bookings."
2. **Book Court 2**:
   * Tap back to Home (notice the badge shows `1`).
   * Open **Squash Studio North**, pick **11:00 AM**, and tap **Confirm Booking**.
   * "My Bookings" now displays **both** cards.
3. **Cancel with Abort**:
   * Tap **Cancel Booking** on Central Sports Arena.
   * The confirmation modal appears.
   * Tap **Keep Booking**.
   * The modal dismisses and your booking remains safe.
4. **Cancel with Confirmation**:
   * Tap **Cancel Booking** on Central Sports Arena again.
   * Tap the red **Cancel Booking** button inside the dialog.
   * The SnackBar appears: *"Booking for Central Sports Arena has been cancelled."*
   * Central Sports Arena disappears; Squash Studio North stays in place.
5. **Delete Last Booking & Check Empty State**:
   * Tap **Cancel Booking** on Squash Studio North and confirm.
   * The list empties, and the **Empty State** appears instantly with the "Browse Courts" button.
6. **Return to Home**:
   * Tap "Browse Courts."
   * Check the top-right bookmark icon: **The badge is gone.**

---

## Checkpoint

You can move to Step 14 once:

- [ ] Tapping "Cancel Booking" triggers the confirmation dialog.
- [ ] Tapping "Keep Booking" leaves the reservation intact.
- [ ] Tapping "Cancel Booking" removes the card and displays a SnackBar.
- [ ] Canceling the final booking triggers the Empty State.
- [ ] Returning to Home clears the notification badge.

---

## What You Learned

* Safeguard dialogs protect users against accidental data loss.
* `removeWhere()` filters and deletes matching items in a collection.
* `setState()` immediately updates the UI based on live conditions (`isEmpty`).
* Destructive actions should use error theme colors (`colorScheme.error`).

Next: [Step 14 - Architecture & Verification](14-architecture-and-verification.md)
