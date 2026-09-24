import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:court_booker/main.dart';
import 'package:court_booker/data/sample_data.dart';

void main() {
  setUp(() {
    sessionBookings.clear();
  });

  testWidgets('Renders home screen with title, welcome banner, and sample courts',
      (WidgetTester tester) async {
    // Set a typical mobile phone resolution for test environment
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const CourtBookerApp());
    await tester.pumpAndSettle();

    // Verify AppBar branding
    expect(find.text('Court Booker'), findsOneWidget);

    // Verify Welcome hero section
    expect(find.text('Find & Book Sports Courts'), findsOneWidget);
    expect(find.text('Choose a court and reserve your time.'), findsOneWidget);

    // Verify sample courts rendered
    expect(find.text('Central Sports Arena'), findsOneWidget);
    expect(find.text('Indoor Basketball Court'), findsOneWidget);
    expect(find.text('Tennis Court 01'), findsOneWidget);
    expect(find.text('Squash Studio North'), findsOneWidget);
  });

  testWidgets(
      'Navigates to court details, selects slot, confirms booking, and displays in My Bookings',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const CourtBookerApp());
    await tester.pumpAndSettle();

    // Tap the first "Book Court" button
    final bookButtons = find.widgetWithText(FilledButton, 'Book Court');
    expect(bookButtons, findsWidgets);
    await tester.tap(bookButtons.first);
    await tester.pumpAndSettle();

    // Verify on Court Details screen
    expect(find.text('Choose Date'), findsOneWidget);
    expect(find.text('Available Time Slots'), findsOneWidget);
    expect(find.text('09:00 AM'), findsOneWidget);

    // Before selecting a slot, helper text is shown
    expect(find.text('Please select a time slot to continue.'), findsOneWidget);

    // Select the '09:00 AM' slot
    await tester.tap(find.text('09:00 AM'));
    await tester.pumpAndSettle();

    // Verify slot is selected and check icon is displayed
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);

    // Tap "Review & Confirm Booking"
    final confirmButton =
        find.widgetWithText(FilledButton, 'Review & Confirm Booking');
    expect(confirmButton, findsOneWidget);
    await tester.ensureVisible(confirmButton);
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    // Verify Confirmation Dialog appears
    expect(find.text('Confirm Booking'), findsWidgets);
    expect(find.text('Please review your reservation details:'), findsOneWidget);

    // Confirm booking in the dialog
    final dialogConfirmButton = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.widgetWithText(FilledButton, 'Confirm Booking'),
    );
    await tester.tap(dialogConfirmButton);
    await tester.pumpAndSettle();

    // Should navigate to BookingsScreen
    expect(find.text('My Bookings'), findsOneWidget);
    expect(find.text('Central Sports Arena'), findsOneWidget);
    expect(find.text('Confirmed'), findsOneWidget);
    expect(find.text('09:00 AM'), findsOneWidget);
  });

  testWidgets('Can cancel a booking and display the empty state',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const CourtBookerApp());
    await tester.pumpAndSettle();

    // Navigate to details and create a booking
    await tester.tap(find.widgetWithText(FilledButton, 'Book Court').first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('09:00 AM'));
    await tester.pumpAndSettle();

    final confirmButton =
        find.widgetWithText(FilledButton, 'Review & Confirm Booking');
    await tester.ensureVisible(confirmButton);
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final dialogConfirmButton = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.widgetWithText(FilledButton, 'Confirm Booking'),
    );
    await tester.tap(dialogConfirmButton);
    await tester.pumpAndSettle();

    // Now on My Bookings screen
    expect(find.text('Central Sports Arena'), findsOneWidget);

    // Tap Cancel Booking
    await tester.tap(find.text('Cancel Booking'));
    await tester.pumpAndSettle();

    // Cancellation confirmation dialog appears
    expect(find.text('Cancel Booking'), findsWidgets);

    // Confirm cancellation in dialog
    final dialogCancelButton = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.widgetWithText(FilledButton, 'Cancel Booking'),
    );
    await tester.tap(dialogCancelButton);
    await tester.pumpAndSettle();

    // Verify booking is removed and empty state is shown
    expect(find.text('No Bookings Yet'), findsOneWidget);
    expect(
      find.text(
        "You haven't booked a court yet.\nChoose a court and reserve your first slot.",
      ),
      findsOneWidget,
    );
    expect(find.text('Browse Courts'), findsOneWidget);

    // Tap "Browse Courts" to return to Home
    await tester.tap(find.text('Browse Courts'));
    await tester.pumpAndSettle();

    // Back on Home screen
    expect(find.text('Find & Book Sports Courts'), findsOneWidget);
  });

  testWidgets('Meets accessibility tap target and labeling guidelines on Home screen',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(const CourtBookerApp());
    await tester.pumpAndSettle();

    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    handle.dispose();
  });
}
