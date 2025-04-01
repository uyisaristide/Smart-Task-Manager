import 'package:flutter/material.dart';

import 'styles.dart';

InputDecoration iDecoration({String? hint}) {
  return InputDecoration(hintText: hint, border: StyleUtls.dashInputBorder);
}
