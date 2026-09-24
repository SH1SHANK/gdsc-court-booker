class Booking {
  final String id;
  final String courtId;
  final String courtName;
  final String sport;
  final DateTime date;
  final String timeSlot;
  final String status;

  Booking({
    required this.id,
    required this.courtId,
    required this.courtName,
    required this.sport,
    required this.date,
    required this.timeSlot,
    this.status = 'Confirmed',
  });
}
