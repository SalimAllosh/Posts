import 'package:flutter/material.dart';

class ShowSnakBar {
  static void showSuccessSnakBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Colors.green[400],
      ),
    );
  }

  static void showErrorSnakBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Colors.red[600],
      ),
    );
  }
}
