import 'package:flutter/material.dart';
import 'package:meta_note/screens/home_screen.dart';
import 'package:meta_note/utils/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _iconAnimation;

  late AnimationController _textAnimationController;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    // 기존 코드
    // Future.delayed(
    //   const Duration(seconds: 1),
    //   () => {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (_) => const HomeScreen(),
    //       ),
    //     )
    //   },
    // );
    // 아이콘 애니메이션
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _iconAnimation =
        Tween<double>(begin: 150, end: 200).animate(_animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              }
            },
          );
    _animationController.forward();
    // 텍스트 애니메이션
    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _textAnimation =
        Tween<double>(begin: 50, end: 60).animate(_textAnimationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              }
            },
          );
    _textAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              color: AppTheme.accent,
              size: _iconAnimation.value,
            ),
            Text(
              "MetaNote",
              style: TextStyle(
                color: AppTheme.accent,
                fontSize: _textAnimation.value,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
