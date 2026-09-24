import 'package:flutter/material.dart';
import '../models/court.dart';
import '../data/sample_data.dart';
import '../widgets/court_card.dart';
import 'court_details_screen.dart';
import 'bookings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openCourtDetails(Court court) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourtDetailsScreen(court: court),
      ),
    );
    // Refresh to update the bookings count in the AppBar badge
    setState(() {});
  }

  void _openMyBookings() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BookingsScreen(),
      ),
    );
    // Refresh to update the bookings count in the AppBar badge
    setState(() {});
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
        actions: [
          IconButton(
            tooltip: 'My Bookings',
            icon: Badge.count(
              count: sessionBookings.length,
              isLabelVisible: sessionBookings.isNotEmpty,
              child: const Icon(Icons.bookmark_outline),
            ),
            onPressed: _openMyBookings,
          ),
        ],
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
