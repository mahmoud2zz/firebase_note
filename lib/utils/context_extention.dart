import 'package:flutter/material.dart';

extension ContextExtention on BuildContext {
  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.red.shade800 : Colors.blue.shade500,
      dismissDirection:DismissDirection.horizontal,
      duration:const Duration(seconds: 2),
    ));
  }
}
