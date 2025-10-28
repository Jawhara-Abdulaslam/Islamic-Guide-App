import 'package:finalproject/Onboarding/introscreen.dart';
import 'package:finalproject/controller/app_rout.dart';
import 'package:finalproject/screens/homescreen.dart';
import 'package:finalproject/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'model/app_state.dart';


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Supabase.initialize(
//       url: 'https://dixnevgpfrgvjjvwdvhw.supabase.co',
//       anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
//   );
main(){
/// تحميل الحالة من SharedPreferences قبل تشغيل التطبيق
  final appState = AppState();
  // await appState.loadInitialState();

  runApp(
    ChangeNotifierProvider<AppState>(
      create: (_) => appState,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيقي الإسلامي',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'), // ✅ تحديد اللغة
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFFFF9F0),
        fontFamily: 'Cairo', // إن كنت تستخدم خطوطًا عربية
      ),

      ///  هذه أهم نقطة: ربط الراوتس
      onGenerateRoute: AppRoutes.generateRoute,
        home: IntroScreen(),


      ///  حدد initialRoute بناءً على الحالة (نوضحها في السطر التالي)
      // home: StreamBuilder<AuthState>(
      //   // stream: Supabase.instance.client.auth.onAuthStateChange,
      //   builder: (context, snapshot) {
      //     // final session = Supabase.instance.client.auth.currentSession;
      //     // if (session != null) {
      //     //   return HomeScreen();/*SplashScreen();*/ // أو HomeScreen مباشرة
      //     // } else {
      //     //   return const IntroScreen();
      //     // }
      //    },
      // ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:untitled9/Onboarding/introscreen.dart';
// import 'package:untitled9/screens/homescreen.dart';
// import 'auth/login.dart';
// import 'home.dart';
// import 'splashscreen/splashscreen.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Supabase.initialize(
//     url: 'https://dixnevgpfrgvjjvwdvhw.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRpeG5ldmdwZnJndmpqdndkdmh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk5MjIyMDIsImV4cCI6MjA3NTQ5ODIwMn0.bH6mjV-ormy4rF7ERqQuhsCCR_-V0tcYLP_0rGI5vXg',
//
//   );
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Supabase Auth App',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         scaffoldBackgroundColor: const Color(0xFFFFF9F0),
//       ),
//       debugShowCheckedModeBanner: false,
//       home: StreamBuilder<AuthState>(
//         stream: Supabase.instance.client.auth.onAuthStateChange,
//         builder: (context, snapshot) {
//           final session = Supabase.instance.client.auth.currentSession;
//           if (session != null) {
//             return    SplashScreen();//HomePage();
//           } else {
//             return const IntroScreen();//LoginPage();
//           }
//         },
//       ),
//     );
//   }
// }
