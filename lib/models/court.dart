import 'package:flutter/material.dart';

class Court {
  final String id;
  final String name;
  final String sport;
  final String location;
  final String description;
  final IconData icon;
  final List<String> availableSlots;

  const Court({
    required this.id,
    required this.name,
    required this.sport,
    required this.location,
    required this.description,
    required this.icon,
    required this.availableSlots,
  });
}
