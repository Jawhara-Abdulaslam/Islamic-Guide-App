// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../screens/homescreen.dart';
// import 'login.dart';
// // import '../../../aslm_app/lib/wg/Home.dart';
//
// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});
//
//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }
//
// class _SignupPageState extends State<SignupPage> {
//   // final TextEditingController _usernameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool loading = false;
//   final supabase = Supabase.instance.client;
//
//   Future<void> _signup() async {
//     setState(() => loading = true);
//     try {
//       final response = await supabase.auth.signUp(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       if (response.user != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("لديك حساب! من فضلك ادخل.")),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const LoginPage()),
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
//                 '🌿 انشاء حساب',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),
//               TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'ايميل',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: 'كلمة السر',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: loading ? null : _signup,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF7FC7AF),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: loading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text('انشاء'),
//               ),
//               const SizedBox(height: 15),
//               TextButton(
//                 onPressed: () => Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (_) => const HomeScreen()),
//                 ),
//                 child: const Text("لديك حساب?ادخل"),
//               ),
//             ],
//           ),
//         ),
//       ),
//       ),
//     );
//   }
// }
