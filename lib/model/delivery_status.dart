import 'package:flutter/material.dart';

class DeliveryStatus {
  final String title;
  final String? description;
  final bool isCompleted;
  final Widget icon;

  const DeliveryStatus({
    required this.title,
    this.description,
    required this.isCompleted,
    required this.icon,
  });
}
