import 'package:flutter/material.dart';

extension StringCheck on String? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}

extension DateTimeExtension on DateTime {
  DateTime at(TimeOfDay time) {
    return copyWith(hour: time.hour, minute: time.minute);
  }
}
