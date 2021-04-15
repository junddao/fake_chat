import 'dart:io';

import 'package:flutter/material.dart';

class SelectedData {
  DateTime pickedDate;
  TimeOfDay time;
  String myId;
  String yourId;
  // File myImage;
  File yourImage;
  SelectedData({
    this.pickedDate,
    this.time,
    this.myId,
    this.yourId,
    // this.myImage,
    this.yourImage,
  });
}
