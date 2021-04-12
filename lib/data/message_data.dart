import 'package:flutter/material.dart';

class MessageData {
  String message;
  bool isMine;
  TimeOfDay t;
  MessageData({
    this.message,
    this.isMine,
    this.t,
  });
}
