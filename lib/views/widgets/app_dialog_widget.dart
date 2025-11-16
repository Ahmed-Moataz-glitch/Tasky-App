import 'package:flutter/material.dart';

abstract class AppDialogWidget {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            spacing: 10,
            children: const [
              CircularProgressIndicator.adaptive(
                backgroundColor: Color(0xff5F33E1),
              ),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showError(BuildContext context, {required String errorMessage}) {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => PopScope(
        canPop: true,
        child: AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xffff0000),
            ),
          ),
          content: Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff000000),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5F33E1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
