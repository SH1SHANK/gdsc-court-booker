# Step 12 - Build the My Bookings Screen

## What We're Building

In this step, we will build the full **"My Bookings"** screen (`lib/screens/bookings_screen.dart`) and its companion card **`BookingCard`** (`lib/widgets/booking_card.dart`).

The screen cleanly manages two distinct states:
1. **Empty State**: When `sessionBookings.isEmpty`, it shows an illustration, friendly copy, and a **Browse Courts** button to steer students back to the venue catalog.
2. **Bookings List**: When reservations exist, it uses **`ListView.builder`** to render each booking with court name, sport badge, green confirmed status, formatted date, time slot, and a red **Cancel Booking** button.

```text
EMPTY STATE                                BOOKED STATE
+---------------------------------------+  +---------------------------------------+
| < My Bookings                         |  | < My Bookings                         |
+---------------------------------------+  +---------------------------------------+
|                                       |  | +-----------------------------------+ |
|                 (📅)                  |  | | Central Sports Arena [Badminton]  | |
|                                       |  | | Status: (✅) Confirmed            | |
|           No Bookings Yet             |  | | --------------------------------- | |
|    You haven't booked a court yet.    |  | | 📅 Thu, Sep 24, 2026              | |
|     Choose a court and reserve...     |  | | 🕒 09:00 AM                       | |
|                                       |  | |              [ ❌ Cancel Booking] | |
|          [ 🎾 Browse Courts ]         |  | +-----------------------------------+ |
|                                       |  +---------------------------------------+
+---------------------------------------+
```

---

## What You'll Learn

* What an **empty state** is and why it keeps users from getting lost
* How **`ListView.builder`** works like a sushi conveyor belt to save device memory
* How to build a custom `BookingCard` component
* How to style buttons with error/destructive theme colors (`colorScheme.error`)
* How to use **`Navigator.canPop(context)`** before calling `pop()`

---

## Programming Concepts for Complete Beginners

### 1. What is an Empty State?
When a student opens "My Bookings" for the first time, the list is empty.
* A sloppy app shows a blank white screen. The user wonders: *"Is it broken? Did my internet drop?"*
* A well-crafted app shows an **Empty State**: an icon, clear messaging (*"No Bookings Yet"*), and a call-to-action button (*"Browse Courts"*) that guides them on what to do next.

### 2. `ListView` vs `ListView.builder`: The Buffet vs Conveyor Belt
* Standard `ListView(children: [...])`: Like a giant buffet where all food is prepared upfront. If you have 500 items, it builds 500 widgets in memory immediately. On budget phones, that stutters.
* **`ListView.builder`**: Like a sushi conveyor belt. It only constructs the 3 or 4 cards currently visible on the physical glass. As you scroll down, it builds new cards on demand and recycles off-screen ones. It is fast, smooth, and respects device RAM.

---

## Step 1 - Create `lib/widgets/booking_card.dart`

Inside `lib/widgets/`, create `booking_card.dart`:

```text
lib/
└── widgets/
    ├── court_card.dart
    └── booking_card.dart
```

Open `lib/widgets/booking_card.dart` and add the component code:

```dart
import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../data/sample_data.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback onCancel;

  const BookingCard({
    super.key,
    required this.booking,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Semantics(
      label:
          'Booking for ${booking.courtName}, ${booking.sport} on ${formatDate(booking.date)} at ${booking.timeSlot}. Status: ${booking.status}',
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        elevation: 0,
        color: colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.courtName,
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
                            booking.sport,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.green.shade600,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 14,
                          color: Colors.green.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          booking.status,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1),
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formatDate(booking.date),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    booking.timeSlot,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    side: BorderSide(color: colorScheme.error.withValues(alpha: 0.6)),
                    minimumSize: const Size(120, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.cancel_outlined, size: 18),
                  label: const Text('Cancel Booking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Step 2 - Update `lib/screens/bookings_screen.dart`

Now open `lib/screens/bookings_screen.dart`. Replace the starter stub with the full implementation:

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
    // We will build the full deletion safeguard dialog in Step 13!
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cancel tapped for ${booking.courtName}'),
      ),
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
                        // Safely return to the court list
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

## Run the App

Save both files. Press **`r`** in your terminal for Hot Reload.

---

## What You Should See

### Scenario A: Empty State
1. If you haven't made any reservations yet (or if you hit `R` for Hot Restart), tap the bookmark icon on the Home Screen.
2. The empty state greets you:
   * A soft circular badge with a calendar icon
   * **No Bookings Yet**
   * Helpful subtext
   * A **Browse Courts** button
3. Tap **Browse Courts**: The app pops smoothly back to the Home Screen.

### Scenario B: Active Bookings List
1. From Home, open **Tennis Court 01**.
2. Pick a date, choose **03:00 PM**, and confirm.
3. You're routed straight to "My Bookings":
   * The empty state is gone.
   * A clean `BookingCard` displays:
     * **Tennis Court 01** [Tennis]
     * Status pill: `(✅) Confirmed`
     * Date: `formatDate(booking.date)`
     * Time: `03:00 PM`
     * A red **Cancel Booking** button in the lower-right corner.

---

## Common Mistakes

### 1. Forgetting `itemCount` in `ListView.builder`
* **The mistake**: Omitting `itemCount: sessionBookings.length`.
* **What you see**: Flutter tries to build infinitely many list items. As soon as the index exceeds the list size, the app crashes with: `RangeError (index): Invalid value: Valid value range is empty: 0`.
* **The fix**: Always provide `itemCount: sessionBookings.length` so `ListView.builder` knows exactly how many rows to produce.

### 2. Forgetting the empty state check
* **The mistake**: Jumping straight to `ListView.builder` without checking `if (sessionBookings.isEmpty)`.
* **What you see**: When a student has no bookings, the screen is completely blank and white. They have no idea if the app is loading, broken, or empty.
* **The fix**: Always handle the zero-data scenario first with a helpful visual empty state and an action button to guide them back to court listings.

### 3. Calling `Navigator.pop` when `canPop` is false
* **The mistake**: Writing `Navigator.pop(context)` on the "Browse Courts" button without checking if there is a screen behind it.
* **What you see**: If the user reached "My Bookings" via `pushReplacement`, there might not be a previous route to pop, potentially exiting the app.
* **The fix**: Guard with `if (Navigator.canPop(context)) Navigator.pop(context) else Navigator.pushReplacement(...)`.

### 4. Nesting `ListView.builder` inside a `Column` without constraints
* **The mistake**: Placing `ListView.builder` directly inside a `Column` without an `Expanded` widget.
* **What you see**: Crash with `Vertical viewport was given unbounded height.`
* **The fix**: Wrap the `ListView.builder` in an `Expanded` widget so Flutter knows how much vertical height the list is allowed to occupy.

---

## Checkpoint

You can move to Step 13 once:

- [ ] `lib/widgets/booking_card.dart` passes `flutter analyze`.
- [ ] An empty bookings list displays the friendly empty state and "Browse Courts" button.
- [ ] Tapping "Browse Courts" safely returns to `HomeScreen`.
- [ ] Creating a booking renders the active `BookingCard` with date, time, and confirmed badge.

---

## What You Learned

* Empty states keep users oriented when there is no data to display.
* `ListView.builder` renders rows on demand, conserving memory and ensuring 60fps scrolling.
* `BookingCard` encapsulates reservation details into a clean, reusable component.
* `Navigator.canPop(context)` checks if a page can safely be dismissed before calling `pop()`.

Next: [Step 13 - Add Cancellation Safeguard](13-add-cancellation-safeguard.md)
