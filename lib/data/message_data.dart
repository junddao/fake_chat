import 'package:flutter/material.dart';

class MessageData {
  final String message;
  final bool isMine;
  final bool? dividerDate;
  final TimeOfDay t;
  MessageData({
    required this.message,
    required this.isMine,
    this.dividerDate,
    required this.t,
  });
}
