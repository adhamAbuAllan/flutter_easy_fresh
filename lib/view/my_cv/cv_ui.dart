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
            border: Border.all(color: Colors.white.withOpacity(0.2)),
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

  Widget _buildProjectItem(String title, String url, WidgetRef ref) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
        ),
      ),
      trailing: Icon(
        Icons.open_in_new,
        color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
      ),
      onTap: () => _launchURL(url),
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
                    // const SizedBox(height: 8),
                    // TextButton(
                    //   onPressed:
                    //       () => _launchURL(
                    //         'https://wa'
                    //         '.me/972569339613',
                    //       ),
                    //   child: Text(
                    //     '📱 +972 569339613',
                    //     style: TextStyle(
                    //       color: ref
                    //           .read(themeModeNotifier.notifier)
                    //           .textTheme(ref: ref),
                    //       decoration: TextDecoration.underline,
                    //     ),
                    //   ),
                    // ),
                    // TextButton(
                    //   onPressed:
                    //       () => _launchURL('mailto:adhamallan4@gmail.com'),
                    //   child: Text(
                    //     '📧 adhamallan4@gmail.com',
                    //     style: TextStyle(
                    //       color: ref
                    //           .read(themeModeNotifier.notifier)
                    //           .textTheme(ref: ref),
                    //       decoration: TextDecoration.underline,
                    //     ),
                    //   ),
                    // ),
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
              // const SizedBox(height: 24),
              // _buildSectionTitle('Projects', ref),
              // _buildGlassContainer(
              //   child: Column(
              //     children: [
              //       _buildProjectItem(
              //         'Ween Balaqee App',
              //         'https://github'
              //             '.com/adhamAbuAllan/ween_blaqe',
              //         ref,
              //       ),
              //       _buildProjectItem(
              //         'Unizone App',
              //         'https://github'
              //             '.com/unizone101/unizone-mobile',
              //         ref,
              //       ),
              //     ],
              //   ),
              //   ref: ref,
              // ),
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

// import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() => runApp(const PortfolioApp());
//
// class PortfolioApp extends StatelessWidget {
//   const PortfolioApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const PortfolioScreen(),
//     );
//   }
// }
//
// class PortfolioScreen extends StatelessWidget {
//   const PortfolioScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             HeaderSection(),
//             SizedBox(height: 32),
//             AboutSection(),
//             SizedBox(height: 32),
//             SkillsSection(),
//             SizedBox(height: 32),
//             ProjectsSection(),
//             SizedBox(height: 32),
//             CoursesSection(),
//             SizedBox(height: 32),
//             DownloadCVButton(),
//             SizedBox(height: 32),
//             ContactFormSection(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class HeaderSection extends StatelessWidget {
//   const HeaderSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("👋 Hi, I'm",
//             style: TextStyle(color: Colors.white70, fontSize: 18)),
//         AnimatedTextKit(
//           animatedTexts: [
//             TypewriterAnimatedText(
//               'Adham Abu Allan',
//               textStyle: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold),
//               speed: const Duration(milliseconds: 100),
//             ),
//           ],
//           totalRepeatCount: 1,
//           pause: const Duration(milliseconds: 1000),
//           displayFullTextOnTap: true,
//         ),
//         const Text("Flutter Developer",
//             style: TextStyle(color: Colors.blueAccent, fontSize: 24)),
//       ],
//     );
//   }
// }
//
// class AboutSection extends StatelessWidget {
//   const AboutSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       "I’m a passionate Flutter developer with 4+ years of experience building elegant and high-performance apps. I specialize in state management, Firebase, Supabase, Laravel APIs, Google Maps, habit tracking, productivity tools, and more.",
//       style: TextStyle(color: Colors.white70, fontSize: 16),
//     );
//   }
// }
//
// class SkillsSection extends StatelessWidget {
//   const SkillsSection({super.key});
//
//   final List<String> skills = const [
//     "Flutter",
//     "Dart",
//     "Firebase",
//     "Supabase",
//     "Laravel",
//     "REST APIs",
//     "Google Maps",
//     "Figma",
//     "Riverpod",
//     "State Management",
//     "UI/UX"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children: skills
//           .map((skill) => Chip(
//         label: Text(skill),
//         backgroundColor: Colors.blueAccent,
//         labelStyle: const TextStyle(color: Colors.white),
//       ))
//           .toList(),
//     );
//   }
// }
//
// class ProjectsSection extends StatelessWidget {
//   const ProjectsSection({super.key});
//
//   final List<String> projects = const [
//     "📱 Atomic Habits Tracker",
//     "🏘️ Apartment Listings App",
//     "⌨️ Keyboard Theme Customizer",
//     "✉️ AI Message Generator"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: projects
//           .map((p) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4),
//         child: Text(p,
//             style: const TextStyle(color: Colors.white, fontSize: 16)),
//       ))
//           .toList(),
//     );
//   }
// }
//
// class CoursesSection extends StatelessWidget {
//   const CoursesSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         Text("🎓 Flutter App Creation: Google Maps Integration Guide",
//             style: TextStyle(color: Colors.white, fontSize: 16)),
//         Text(
//           "Embedded Google Maps, custom routes, markers, shapes, and real-time tracking.",
//           style: TextStyle(color: Colors.white70, fontSize: 14),
//         ),
//       ],
//     );
//   }
// }
//
// class DownloadCVButton extends StatelessWidget {
//   const DownloadCVButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: () async {
//         const url = 'https://example.com/adham-cv.pdf';
//         if (await canLaunchUrl(Uri.parse(url))) {
//           await launchUrl(Uri.parse(url));
//         }
//       },
//       icon: const Icon(Icons.download),
//       label: const Text("Download CV"),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blueAccent,
//         foregroundColor: Colors.white,
//       ),
//     );
//   }
// }
//
// class ContactFormSection extends StatefulWidget {
//   const ContactFormSection({super.key});
//
//   @override
//   State<ContactFormSection> createState() => _ContactFormSectionState();
// }
//
// class _ContactFormSectionState extends State<ContactFormSection> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _messageController = TextEditingController();
//
//   void _sendEmail() {
//     final Uri emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: 'adham@example.com',
//       queryParameters: {
//         'subject': 'Portfolio Contact from ${_nameController.text}',
//         'body': _messageController.text + "\n\nFrom: ${_emailController.text}"
//       },
//     );
//
//     launchUrl(emailLaunchUri);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("📫 Contact Me", style: TextStyle(color: Colors.white, fontSize: 18)),
//           const SizedBox(height: 12),
//           TextFormField(
//             controller: _nameController,
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               hintText: 'Your Name',
//               hintStyle: TextStyle(color: Colors.white38),
//               enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
//             ),
//           ),
//           TextFormField(
//             controller: _emailController,
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               hintText: 'Your Email',
//               hintStyle: TextStyle(color: Colors.white38),
//               enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
//             ),
//           ),
//           TextFormField(
//             controller: _messageController,
//             maxLines: 4,
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               hintText: 'Your Message',
//               hintStyle: TextStyle(color: Colors.white38),
//               enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
//             ),
//           ),
//           const SizedBox(height: 12),
//           ElevatedButton(
//             onPressed: _sendEmail,
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
//             child: const Text("Send Message"),
//           ),
//         ],
//       ),
//     );
//   }
// }
