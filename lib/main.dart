import 'package:flutter/material.dart';
import 'package:meta_note/screens/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

// 빌드하는 방법 : flutter build windows

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // flutter pub window-manager
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(400, 700),
    size: Size(600, 700),
    center: true,
    title: 'MetaNote',
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
