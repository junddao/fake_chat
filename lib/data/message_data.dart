import 'package:flutter/material.dart';

class MessageData {
  String message;
  bool isMine;
  bool deviderDate;
  TimeOfDay t;
  MessageData({
    this.message,
    this.isMine,
    this.deviderDate,
    this.t,
  });
}
