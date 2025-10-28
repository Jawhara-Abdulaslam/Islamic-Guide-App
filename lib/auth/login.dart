// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../screens/homescreen.dart';
// import 'signup.dart';
// // import '../Home.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool loading = false;
//   final supabase = Supabase.instance.client;
//
//   Future<void> _login() async {
//     setState(() => loading = true);
//     try {
//       final response = await supabase.auth.signInWithPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       if (response.session != null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const HomeScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("غير صحيح الايميل او كلمه السر.")),
//         );
//       }
//     } on AuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
//     } finally {
//       setState(() => loading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//       backgroundColor: const Color(0xFFFFF9F0),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             children: [
//               const Text(
//                 '🌱سررنا بعودتك!',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),
//               TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'الايميل',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: 'كلمه السر',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: loading ? null : _login,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF7FC7AF),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: loading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text('دخول'),
//               ),
//               const SizedBox(height: 15),
//               TextButton(
//                 onPressed: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const SignupPage()),
//                 ),
//                 child: const Text("ليس لديك حساب؟ انشاء حساب"),
//               ),
//             ],
//           ),
//         ),
//       ),
//       ),
//     );
//   }
// }
