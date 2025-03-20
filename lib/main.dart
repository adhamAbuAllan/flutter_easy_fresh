import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easy_fresh/contoller/methods/change_theme_mode.dart';
import 'package:flutter_easy_fresh/contoller/methods/language_notifier.dart';
import 'package:flutter_easy_fresh/contoller/providers/languate_provider.dart';
import 'package:flutter_easy_fresh/contoller/providers/video_provider.dart';
import 'package:flutter_easy_fresh/session/new_session.dart';
import 'package:flutter_easy_fresh/view/splach_screen_ui.dart';
import 'package:flutter_easy_fresh/view/video_home.dart';
import 'package:flutter_easy_fresh/view/widgets/container_logout_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/video_filter_bar_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const/get_it_controller.dart';
import 'const/localization.dart';
import 'const/nums.dart';
import 'const/strings.dart';
import 'contoller/providers/color_provider.dart';
import 'contoller/providers/language_proivder.dart';

final Future<SharedPreferences> sp = SharedPreferences.getInstance();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NewSession.init();

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
      child:
          //YouTubeHomePage()
          const MyApp(),
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
      home: const
      // ABCDEFG(),

      YouTubeHomePage(),
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

// class ABCDEFG extends ConsumerStatefulWidget {
//   const ABCDEFG({super.key});
//
//   @override
//   ConsumerState createState() => _ABCDEFGState();
// }

// class _ABCDEFGState extends ConsumerState<ABCDEFG> {
//   var listOfVideos = [];
//   double fontSize = 20;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       Future.microtask(() {
//         ref.read(videoNotifierProvider.notifier).getAllVideos(context:context,);
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ColorfulSafeArea(
//       child: Scaffold(
//         drawer: Drawer(
//           backgroundColor: Colors.black,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 38.0),
//             child: ContainerMenuWidget(
//               isLogined: false,
//               onChange: (value) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) async {
//                   setState(() {
//                     ref
//                         .watch(themeModeNotifier.notifier)
//                         .toggleThemeMode(value);
//                   });
//                 });
//               },
//             ),
//           ),
//         ),
//         drawerScrimColor: Colors.black.withAlpha(50),
//
//         backgroundColor: Colors.black,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 300),
//             Center(
//               child:
//                   ref.watch(videoNotifierProvider).loading
//                       ? CircularProgressIndicator(color: Colors.white)
//                       : ListView.builder(
//                         shrinkWrap: true,
//                         itemCount:
//                             ref
//                                 .watch(videoNotifierProvider)
//                                 .playListItems
//                                 ?.length ??
//                             0,
//                         itemBuilder: (context, index) {
//                           final video =
//                               ref
//                                   .watch(videoNotifierProvider)
//                                   .playListItems?[index];
//
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Center(
//                               child: Text(
//                                 video?.videoTitle ?? "No Title",
//                                 style: TextStyle(color: Colors.white),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//             ),
//             SizedBox(
//               height: 50,
//               child: Row(
//                 spacing: 16,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       WidgetsBinding.instance.addPostFrameCallback((_) async {
//                         Future.microtask(() {
//                           if (NewSession.get("language", "") == "ar") {
//                             debugPrint("arabic");
//                           } else {
//                             debugPrint("english");
//                           }
//                           ref
//                               .read(videoNotifierProvider.notifier)
//                               .getAllVideos(context:context,
//                                 listPlayId:
//                                     "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t", context: context,
//                               );
//                         });
//                       });
//                     },
//                     child: Text("list 1"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       WidgetsBinding.instance.addPostFrameCallback((_) async {
//                         Future.microtask(() {
//                           ref
//                               .read(videoNotifierProvider.notifier)
//                               .getAllVideos(context:context,
//                                 listPlayId:
//                                     "PLiMj4nUvC2Jgrw2d4XuhEDE_X69eHRJvX", context: context,
//                               );
//                         });
//                       });
//                     },
//                     child: Text("list 2"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       WidgetsBinding.instance.addPostFrameCallback((_) async {
//                         Future.microtask(() {
//                           ref
//                               .read(videoNotifierProvider.notifier)
//                               .getAllVideos(context:context,
//                                 listPlayId:
//                                     "PLiMj4nUvC2JhWsxIN77Fi-chkVERDFUtt", context: context,
//                               );
//                         });
//                       });
//                     },
//                     child: Text("list 3"),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 50,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: VideoFilterBarWidgetA(),
//               ),
//             ),
//             // SizedBox(
//             //   height: 50,
//             //   child: Row(
//             //     spacing: 16,
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     crossAxisAlignment: CrossAxisAlignment.center,
//             //     children: [
//             //       ElevatedButton(onPressed: () {
//             //         WidgetsBinding.instance.addPostFrameCallback((_) async {
//             //           VideoState videoState = VideoState();
//             //
//             //           Future.microtask(() {
//             //             ref
//             //                 .read(videoNotifierProvider.notifier)
//             //                 .getAllVideos(context:context,
//             //               listPlayId: "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t"
//             //             );
//             //           });
//             //         });
//             //       }, child: Text("under 30 m")),
//             //       ElevatedButton(onPressed: () {
//             //         WidgetsBinding.instance.addPostFrameCallback((_) async {
//             //           VideoState videoState = VideoState();
//             //
//             //           Future.microtask(() {
//             //             ref
//             //                 .read(videoNotifierProvider.notifier)
//             //                 .getAllVideos(context:context,
//             //               listPlayId: "PLiMj4nUvC2Jgrw2d4XuhEDE_X69eHRJvX"
//             //             );
//             //
//             //           });
//             //         });
//             //       }, child: Text("30 - 60 m")),
//             //       ElevatedButton(onPressed: () {
//             //         WidgetsBinding.instance.addPostFrameCallback((_) async {
//             //           VideoState videoState = VideoState();
//             //
//             //           Future.microtask(() {
//             //             ref
//             //                 .read(videoNotifierProvider.notifier)
//             //                 .getAllVideos(context:context,
//             //               listPlayId: "PLiMj4nUvC2JhWsxIN77Fi-chkVERDFUtt"
//             //             );
//             //           });
//             //         });
//             //       }, child: Text("above 60 m")),
//             //     ],
//             //
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
