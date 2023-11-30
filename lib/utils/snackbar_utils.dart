import 'package:flutter/material.dart';
import 'package:meta_note/utils/app_styles.dart';

class SnackBarUtils {
  static void showSnackBar(
      BuildContext context, IconData icon, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.accent,
            ),
            const SizedBox(width: 5),
            Text(message),
          ],
        ),
      ),
    );
  }
}
