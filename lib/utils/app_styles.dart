import "package:flutter/material.dart";

// 아이콘 경로는 windows/runner/resources

class AppTheme {
  static const Color dark = Color(0xFF1E1E1E);
  static const Color medium = Color(0x50FFFFFF); // dark & light 모두 사용가능한 중간 흰색
  static const Color splash = Color(0xFF9b59b6);
  static const Color accent = Color.fromARGB(255, 150, 68, 182);
  static const Color light = Color(0xFFFFFFFF);

  static const Color disabledBackgroundColor = Colors.black12;
  static const Color disabledForegroundColor = Colors.white12;

  static const TextStyle textStyle20 = TextStyle(color: light, fontSize: 15);
  static const TextStyle hintStyle = TextStyle(color: medium);
  static const TextStyle counterStyle = TextStyle(color: medium, fontSize: 10);
  // static const TextStyle splashStyle = TextStyle(
  //   color: accent,
  //   fontSize: 60,
  //   fontStyle: FontStyle.italic,
  //   fontWeight: FontWeight.w500,
  // );
}
