import 'dart:async';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/const/nums.dart';
import 'package:flutter_easy_fresh/contoller/providers/color_provider.dart';
import 'package:flutter_easy_fresh/contoller/providers/language_proivder.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../const/strings.dart';
import '../contoller/providers/video_provider.dart';
import '../session/new_session.dart';

class SplashScreenUi extends ConsumerStatefulWidget {
  const SplashScreenUi({super.key});

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreenUi> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(themeModeNotifier.notifier).loadThemeMode();
      themeMode.loadValue();

      ref.read(languageNotifier.notifier);
      if (NewSession.get("language", "").isEmpty) {
        NewSession.save("language", "ar");
      }
      await navigateToHome();

    });
    // Navigator.pushReplacementNamed(context, MyPagesRoutes.main);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ref.read(themeModeNotifier.notifier).containerTheme(ref: ref),
      body: ColorfulSafeArea(
        bottomColor: Colors.transparent,
        color: ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CircularProgressIndicator(
                  color: ref
                      .read(themeModeNotifier.notifier)
                      .primaryTheme(ref: ref),
                ),
                Text("loading...",
                    style: TextStyle(
                      color: ref
                          .read(themeModeNotifier.notifier)
                          .textTheme(ref: ref),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cairo",
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navigateToHome() async {
    // Check if it's the first time
    if (NewSession.get("isFirstTime", "") != "OK") {
      NewSession.save("language", "ar");
    }

    // Use addPostFrameCallback without awaiting

  }
}
