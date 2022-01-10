import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ErrorSnackbar {
  static void show(BuildContext context, String message) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      backgroundColor: Colors.red.withOpacity(0.8),
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 30,
      ),
      titleText: const Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    ).show(context);
  }
}
