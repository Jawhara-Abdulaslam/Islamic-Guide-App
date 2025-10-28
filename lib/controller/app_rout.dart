
import 'package:flutter/material.dart';
import '../screens/QuranIndexPage.dart';
import '../screens/allah_names_screen.dart';
import '../screens/hisnulmuslim_screen.dart';
import '../screens/homescreen.dart';
import '../screens/wird_night_morning_screen.dart';
import '../screens/zkar_after_pray_screen.dart';
import '../splashscreen/splashscreen.dart';



class AppRoutes {
  // تعريف أسماء الراوتس
  static const String splash = '/';               // عادة نقطة البداية
  // static const String intro = '/intro';
  static const String home = '/home';
  // static const String login = '/LoginPage';
  // static const String signup = '/SignupPage';
  static const String quran = '/QuranIndexPage';
  static const String hadith = '/HisnulMuslimPage';
  static const String allahNames = '/AllahNamesScreens';
  static const String morningEvening = '/WirdMorningEveningPage';
  static const String afterPrayer = '/ZkarAfterPrayPage';
  // static const String Favorite = '/FavoritPage';

  // دالة تولد الراوت حسب الاسم
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
      // ممكن تستخدم SplashScreen أو IntroScreen كبداية
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // case login:
      //   return MaterialPageRoute(builder: (_) => const LoginPage());
      // case signup:
      //   return MaterialPageRoute(builder: (_) => const SignupPage());
      case home:
         return MaterialPageRoute(builder: (_) => const HomeScreen());
      case quran:
        return MaterialPageRoute(builder: (_) => QuranIndexPage());//PageQuranPage
      case hadith:
        return MaterialPageRoute(builder: (_) => const HisnulMuslimPage());
      case allahNames:
        return MaterialPageRoute(builder: (_) => const AllahNamesScreen());
      case morningEvening:
        return MaterialPageRoute(builder: (_) => const WirdMorningEveningPage());
      case afterPrayer:
        return MaterialPageRoute(builder: (_) => const ZkarAfterPrayPage());
      // case  Favorite:
      //   return MaterialPageRoute(builder: (_) => const  FavoritesScreen());
      default:
      // صفحة الخطأ في حالة راوت غير معروف
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('صفحة غير موجودة')),
            body: const Center(child: Text('الصفحة غير موجودة')),
          ),
        );
    }
  }
}



// import 'package:aslamic_app/screens/allah_names_screen.dart';
// import 'package:aslamic_app/screens/hisnulmuslim_screen.dart';
// import 'package:aslamic_app/screens/homescreen.dart';
// import 'package:aslamic_app/screens/quran_screen.dart';
// import 'package:aslamic_app/screens/wird_night_morning_screen.dart';
// import 'package:aslamic_app/screens/zkar_after_pray_screen.dart';
// import 'package:aslamic_app/splashscreen/splashscreen.dart';
// import 'package:flutter/material.dart';
//
// import '../Onboarding/introscreen.dart';
//
// class AppRoutes {
//   // تعريف أسماء الراوتس
//   // static const String SplashScreen = '/SplashScreen';
//   // static const String IntroScreen = '/IntroScreen';
//
//   static const String quran = '/QuranPage';
//   static const String hadith = '/HisnulMuslimPage';
//   static const String allahNames = '/AllahNamesScreens';
//   static const String morningEvening = '/WirdMorningEveningPage';
//   static const String afterPrayer = '/ZkarAfterPrayPage';
//   static const String home = '/HomeScreen';
//   // static const String favorites = '/favorites';
//   // static const String settings = '/settings';
//   // static const String about = '/about';
//
//   // دالة تولد الراوت حسب الاسم
//   static Route<dynamic>? generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       // case SplashScreen :
//       //   return MaterialPageRoute(builder: (_) => const SplashScreen());
//       // case IntroScreen:
//       //   return MaterialPageRoute(builder: (_) => const IntroScreen());
//       case quran:
//         return MaterialPageRoute(builder: (_) => const QuranPage());
//       case hadith:
//         return MaterialPageRoute(builder: (_) => const HisnulMuslimPage());
//       case allahNames:
//         return MaterialPageRoute(builder: (_) => const AllahNamesScreen());
//       case morningEvening:
//         return MaterialPageRoute(builder: (_) => const WirdMorningEveningPage());
//       case afterPrayer:
//         return MaterialPageRoute(builder: (_) => const ZkarAfterPrayPage() );
//       case home:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//     // case favorites:
//     //   return MaterialPageRoute(builder: (_) => const FavoritesScreen());
//     // case settings:
//     //   return MaterialPageRoute(builder: (_) => const SettingsScreen());
//     // case about:
//     //   return MaterialPageRoute(builder: (_) => const AboutScreen());
//
//       default:
//       // صفحة الخطأ في حالة راوت غير معروف
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             appBar: AppBar(title: const Text('صفحة غير موجودة')),
//             body: const Center(child: Text('الصفحة غير موجودة')),
//           ),
//         );
//     }
//   }
// }