import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easy_fresh/contoller/methods/change_theme_mode.dart';
import 'package:flutter_easy_fresh/contoller/methods/language_notifier.dart';
import 'package:flutter_easy_fresh/contoller/providers/languate_provider.dart';
import 'package:flutter_easy_fresh/contoller/providers/video_provider.dart';
import 'package:flutter_easy_fresh/session/new_session.dart';
import 'package:flutter_easy_fresh/view/splach_screen_ui.dart';
import 'package:flutter_easy_fresh/view/video_home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/video_model.dart';
import 'const/get_it_controller.dart';
import 'const/localization.dart';
import 'const/nums.dart';
import 'const/strings.dart';
import 'contoller/providers/color_provider.dart';
import 'contoller/providers/language_proivder.dart';

/// this app is only for learn and improve the experience!!! , some codes
/// from AI...
final Future<SharedPreferences> sp = SharedPreferences.getInstance();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NewSession.init();
  await Hive.initFlutter();
  Hive.registerAdapter(VideoModelAdapter());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(ChangeThemeMode());

  await configureInjection();

  runApp(
    ProviderScope(
      overrides: [
        languageProvider.overrideWith((ref) => LanguageNotifier(initialLocale)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(languageNotifier.notifier);
      if (NewSession.get("language", "").isEmpty) {
        NewSession.save("language", "ar");
      }
      if (NewSession.get("listVideoId", "def").isNotEmpty) {
        ref.read(currentPlayListIdNotifier.notifier).state = NewSession.get(
          "listVideoId",
          "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t",
        );
      }
      ref.read(themeModeNotifier.notifier).loadThemeMode();
    });
    themeMode.loadValue();
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(languageProvider);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cairo',

        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const YouTubeHomePage(),
      localizationsDelegates: const [
        SetLocalization.localizationsDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: locale,
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'JO')],
      // initialRoute: MyPagesRoutes.splashScreen,
      routes: {
        MyPagesRoutes.main: (context) => const MyApp(),
        MyPagesRoutes.splashScreen: (context) => const SplashScreenUi(),
      },
    );
  }
}
