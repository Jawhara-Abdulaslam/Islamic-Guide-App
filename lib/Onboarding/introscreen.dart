import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../splashscreen/splashscreen.dart';
// import 'package:audioplayers/audioplayers.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<String> texts = [
    'مرحبًا بك في تطبيقنا الإسلامي',
    'تابع أذكارك اليومية',
    'ابدأ رحلتك الإيمانية معنا الآن',
  ];

  // final player = AudioPlayer(); // مشغل الصوت

  @override
  void initState() {
    super.initState();
    // _playWelcomeSound();
  }

  // void _playWelcomeSound() async {
  //   await player.play(AssetSource('sounds/welcome.mp3'));
  // }

  void _finishIntro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_intro', true);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  SplashScreen()),
      );
    }
  }

  void _nextPage() {
    if (_currentIndex < texts.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishIntro();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: texts.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lottie Animation
                      Lottie.asset(
                        'assets/animations/aslamic.json',
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),

                      // Page Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          texts.length,
                              (dotIndex) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentIndex == dotIndex ? 20 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentIndex == dotIndex
                                    ? (isDark ? Colors.white : Colors.black)
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Text Content
                      Text(
                        texts[index],
                        style: TextStyle(
                          fontSize: 24,
                          color: isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),

                      // Next/Start Button
                      if (index == texts.length - 1)
                        ElevatedButton(
                          onPressed: _finishIntro,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? Colors.white : Colors.black,
                            foregroundColor: isDark ? Colors.black : Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'ابدأ الآن',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      else
                        TextButton(
                          onPressed: _nextPage,
                          style: TextButton.styleFrom(
                            foregroundColor: isDark ? Colors.white70 : Colors.grey[600],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'التالي',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),

            // Skip Button
            Positioned(
              top: 16,
              right: 20,
              child: TextButton(
                onPressed: _finishIntro,
                child: Text(
                  'تخطي',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class IntroScreen extends StatefulWidget {
//   const IntroScreen({super.key});
//
//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }
//
// class _IntroScreenState extends State<IntroScreen> {
//   final PageController _controller = PageController();
//   int _currentIndex = 0;
//
//   final List<String> texts = [
//     'مرحبًا بك في تطبيقنا الإسلامي',
//     'تابع أذكارك اليومية ',
//     'ابدأ رحلتك الإيمانية معنا الآن',
//   ];
//
//   void _finishIntro() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('seen_intro', true);
//     if (mounted) {
//       Navigator.of(context).pushReplacementNamed('/splash');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : Colors.white,
//       body: PageView.builder(
//         controller: _controller,
//         itemCount: texts.length,
//         onPageChanged: (index) => setState(() => _currentIndex = index),
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Lottie.asset('assets/animations/aslamic.json', height: 300),
//                 const SizedBox(height: 40),
//                 Text(
//                   texts[index],
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: isDark ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 50),
//                 if (index == texts.length - 1)
//                   ElevatedButton(
//                     onPressed: _finishIntro,
//                     child: const Text('ابدأ الآن',),
//                   )
//                 else
//                   TextButton(
//                     onPressed: () {
//                       _controller.nextPage(
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                       );
//                     },
//                       style: TextButton.styleFrom(
//                         foregroundColor: Colors.black,
//                         textStyle: const TextStyle(fontSize: 18),
//                     ),
//
//                     child: const Text('التالي'),
//                   ),
//                 // ✅ زر "تخطي"
//                 Positioned(
//                   top: 40,
//                   right: 20,
//                   child: TextButton(
//                     onPressed: _finishIntro,
//                     child: const Text(
//                       'تخطي',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//               ],
//             ),
//           );
//         },
//
//       ),
//
//     );
//   }
// }
// Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(builder: (_) => SplashScreen()),
// );