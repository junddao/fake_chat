import 'dart:io';

import 'package:flutter/material.dart';

class SelectedData {
  final DateTime pickedDate;
  final TimeOfDay time;
  final String myId;
  final String yourId;
  // File myImage;
  final File yourImage;
  SelectedData({
    required this.pickedDate,
    required this.time,
    required this.myId,
    required this.yourId,
    required this.yourImage,
  });
}
