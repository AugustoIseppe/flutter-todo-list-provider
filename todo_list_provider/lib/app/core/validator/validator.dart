import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static FormFieldValidator compare(
      TextEditingController? valueEC, String message) {
    return (value) {
      final valueToCompare = valueEC?.text ?? '';
      if (value == null || (value != null && value != valueToCompare)) {
        return message;
      }
      return null;
    };
  }
}
