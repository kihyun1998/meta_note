import "package:flutter/material.dart";
import "package:meta_note/utils/app_styles.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _mainButton(() => null, 'New File'),
                _mainButton(null, 'Save File'),
                Row(
                  children: [
                    _actionButton(() => null, Icons.file_upload),
                    const SizedBox(width: 8),
                    _actionButton(() => null, Icons.folder),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

// _mainButton 기본적인 메인 버튼 위젯
// onPressed : 눌렀을 때 동작하는 함수
// text : 표시될 문자열
  ElevatedButton _mainButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

// _actionButton 아이콘 버튼 위젯
// onPressed : 눌렀을 때 동작하는 함수
// icon : Icons. 으로 값을 받는다.
  IconButton _actionButton(Function()? onPressed, IconData icon) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 20,
      splashColor: AppTheme.splash,
      icon: Icon(icon),
      color: AppTheme.medium,
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.accent,
      foregroundColor: AppTheme.dark,
      disabledBackgroundColor: AppTheme.disabledBackgroundColor,
      disabledForegroundColor: AppTheme.disabledForegroundColor,
    );
  }
}
