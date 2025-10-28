import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToHome(); // ✅ استدعاء الدالة للانتقال إلى الشاشة الرئيسية
  }

  void _navigateToHome() {
    // 🔄 الانتقال إلى الشاشة الرئيسية بعد تأخير 2 ثانية
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // 🖼️ عرض صورة SVG في منتصف الشاشة
        child: SvgPicture.asset(
          'assets/images/noor.svg',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
























// import '../auth/login.dart';
// import '../screens/homescreen.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     // _checkSession();
//   }
//
//   // Future<void> _checkSession() async {
//     // final session = Supabase.instance.client.auth.currentSession;
//
//   //   await Future.delayed(const Duration(seconds: 2));
//   //
//   //   if (session != null && session.user != null) {
//   //     // ✅ المستخدم مسجل دخول
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (_) => HomeScreen()),
//   //     );
//   //   } else {
//   //     // ❌ المستخدم غير مسجل
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (_) => LoginPage()),
//   //     );
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SvgPicture.asset(
//           'assets/images/noor.svg',
//           width: 150,
//           height: 150,
//         Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => HomeScreen()),
//             );
//         ),
//       ),
//     );
//   }
// }


