import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class ContextController extends GetxController {
  static BuildContext? _context;

  static void setContext(BuildContext context) {
    _context = context;
  }

  static BuildContext? getContext() {
    return _context;
  }
}
