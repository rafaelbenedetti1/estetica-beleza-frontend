import 'package:flutter/material.dart';

coalesceEmpty(String obj1, String obj2) {
  if (obj1 == null || obj1.isEmpty) {
    return obj2;
  }
  return obj1;
}

removeSelectedFocus(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}