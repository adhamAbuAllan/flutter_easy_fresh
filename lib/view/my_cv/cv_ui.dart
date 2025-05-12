import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../contoller/providers/color_provider.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adham Abu Allan Portfolio',
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
        scaffoldBackgroundColor: const Color(0xFF1E1E2C),
        primaryColor: Colors.tealAccent,
      ),
      home: const PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends ConsumerWidget {
  const PortfolioScreen({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _buildGlassContainer({required Widget child, required WidgetRef ref}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ref
                .read(themeModeNotifier.notifier)
                .containerTheme(ref: ref),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withAlpha(51)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
        ),
      ),
    );
  }

  Widget _buildSkillChips(List<String> skills, WidgetRef ref) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          skills
              .map(
                (skill) => Chip(
                  label: Text(
                    skill,
                    style: TextStyle(
                      color: ref
                          .read(themeModeNotifier.notifier)
                          .textTheme(ref: ref)
                          .withAlpha(200),
                    ),
                  ),
                  backgroundColor: ref
                      .read(themeModeNotifier.notifier)
                      .backgroundAppTheme(ref: ref),
                ),
              )
              .toList(),
    );
  }

  Widget _buildLinkItem(
    String title,
    String url,
    WidgetRef ref, {
    Widget? customIcon,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
        ),
      ),
      trailing:
          customIcon ??
          Icon(
            Icons.link,
            color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
          ),
      onTap: () => _launchURL(url),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skills = [
      'Flutter',
      'Dart',
      'Firebase',
      'Google Maps',
      'Laravel',
      'API',
      'MVC',
      'Git',
      'MySQL',
      'GetX',
      'Bloc',
      'Provider',
      'Riverpod',
      'HTTP',
      'Push Notifications',
      'Local Notifications',
      'Figma',
      'UI Design',
      'Swift (Basics)',
      'Kotlin (Basics)',
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: ref
            .read(themeModeNotifier.notifier)
            .backgroundAppTheme(ref: ref),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildGlassContainer(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/112254705?v=4&size=64',
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Adham Abu Allan',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                    ),
                    const SizedBox(height: 8),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Mobile Apps Developer',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          speed: const Duration(milliseconds: 130),
                        ),
                      ],
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                    ),
                  ],
                ),
                ref: ref,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Skills', ref),
              _buildGlassContainer(
                child: _buildSkillChips(skills, ref),
                ref: ref,
              ),

              const SizedBox(height: 24),
              _buildSectionTitle('Links', ref),
              _buildGlassContainer(
                child: Column(
                  children: [
                    _buildLinkItem(
                      'GitHub',
                      'https://github'
                          '.com/adhamAbuAllan',
                      ref,
                    ),

                    _buildLinkItem(
                      'CV',
                      'https://drive.google.com/file/d/1PKhi4CnRHYHS-C0ldtkKCFbSgUUI0Aex/view?usp=share_link',
                      ref,
                    ),
                    _buildLinkItem(
                      'buy my coffee',
                      'https://drive.google.com/file/d/1PKhi4CnRHYHS-C0ldtkKCFbSgUUI0Aex/view?usp=share_link',
                      ref,
                    ),
                  ],
                ),
                ref: ref,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
