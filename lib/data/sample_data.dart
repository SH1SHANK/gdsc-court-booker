import 'package:flutter/material.dart';
import '../models/court.dart';
import '../models/booking.dart';

final List<Court> sampleCourts = [
  const Court(
    id: 'court_1',
    name: 'Central Sports Arena',
    sport: 'Badminton',
    location: 'Main Campus, Building A',
    description:
        'Indoor air-conditioned wooden court with tournament-grade lighting and professional net systems.',
    icon: Icons.sports_tennis,
    availableSlots: ['09:00 AM', '10:00 AM', '11:00 AM', '04:00 PM', '05:00 PM'],
  ),
  const Court(
    id: 'court_2',
    name: 'Indoor Basketball Court',
    sport: 'Basketball',
    location: 'Sports Complex, Ground Floor',
    description:
        'Full-court maple wood flooring with adjustable FIBA backboards and electronic scoreboards.',
    icon: Icons.sports_basketball,
    availableSlots: ['08:00 AM', '10:00 AM', '02:00 PM', '06:00 PM', '07:00 PM'],
  ),
  const Court(
    id: 'court_3',
    name: 'Tennis Court 01',
    sport: 'Tennis',
    location: 'Outdoor Athletic Fields',
    description:
        'Synthetic hard court with high-visibility floodlights for evening play and shaded player benches.',
    icon: Icons.sports_tennis,
    availableSlots: ['07:00 AM', '09:00 AM', '03:00 PM', '05:00 PM', '06:00 PM'],
  ),
  const Court(
    id: 'court_4',
    name: 'Squash Studio North',
    sport: 'Squash',
    location: 'Student Activity Hub',
    description:
        'Glass-backed international competition court with shock-absorbent sprung floor.',
    icon: Icons.sports_handball,
    availableSlots: ['11:00 AM', '12:00 PM', '01:00 PM', '04:00 PM', '08:00 PM'],
  ),
];

final List<Booking> sessionBookings = [];

String formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final weekday = weekdays[date.weekday - 1];
  final month = months[date.month - 1];
  return '$weekday, $month ${date.day}, ${date.year}';
}
