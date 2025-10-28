import 'dart:convert';
import '../model/model.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/screens/favorite.dart';

class WirdMorningEveningPage extends StatefulWidget {
  const WirdMorningEveningPage({super.key});

  @override
  State<WirdMorningEveningPage> createState() => _WirdMorningEveningPageState();
}

class _WirdMorningEveningPageState extends State<WirdMorningEveningPage> {
  late Future<List<wird_night_morning>> wirdFuture;
  final List<wird_night_morning> favoriteWirdList = [];

  @override
  void initState() {
    super.initState();
    wirdFuture = loadWird(context);
  }

  Future<List<wird_night_morning>> loadWird(BuildContext context) async {
    final jsonStr =
    await DefaultAssetBundle.of(context).loadString('assets/db_json/wird_night_morning.json');
    final List<dynamic> data = json.decode(jsonStr);
    return data.map((json) => wird_night_morning.fromJson(json)).toList();
  }

  bool isFavorite(wird_night_morning item) {
    return favoriteWirdList.any((fav) => fav.text == item.text);
  }

  void toggleFavorite(wird_night_morning item) {
    setState(() {
      if (isFavorite(item)) {
        favoriteWirdList.removeWhere((fav) => fav.text == item.text);
      } else {
        favoriteWirdList.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F1EB),
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.topCenter,
            child: Text('أذكار الصباح والمساء'),
          ),
          backgroundColor: const Color(0xFF528777),
          elevation: 1,
          titleTextStyle: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: Colors.grey[900]),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FavoritesScreen(favoriteItems:favoriteWirdList),
                  ),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<wird_night_morning>>(
          future: wirdFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('خطأ: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('لا توجد بيانات'));
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(12.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            item.text,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              IconButton(
                                icon: Icon(
                                  isFavorite(item) ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite(item) ? Colors.green : Colors.grey,
                                ),
                                onPressed: () => toggleFavorite(item),
                              ),
                            ],
                          ),
                          Text(
                            'عدد التكرار: × ${item.counter}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}



// import '../model/model.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
//
// class WirdMorningEveningPage extends StatefulWidget {
//   const WirdMorningEveningPage({super.key});
//
//   @override
//   State<WirdMorningEveningPage> createState() => _WirdMorningEveningPageState();
// }
//
// class _WirdMorningEveningPageState extends State<WirdMorningEveningPage> {
//   late Future<List<wird_night_morning>> wirdFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     wirdFuture = loadWird(context);
//   }
//
//   Future<List<wird_night_morning>> loadWird(BuildContext context) async {
//     final jsonStr =
//     await DefaultAssetBundle.of(context).loadString('assets/db_json/wird_night_morning.json');
//     final List<dynamic> data = json.decode(jsonStr);
//     return data.map((json) => wird_night_morning.fromJson(json)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl, // لجعل النص من اليمين لليسار
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F1EB),
//         appBar: AppBar(
//           title: Align(
//             alignment: Alignment.topCenter,
//             child: Text('أذكار الصباح والمساء'),
//           ),
//           backgroundColor: const Color(0xFF528777),
//           elevation: 1,
//           titleTextStyle: TextStyle(
//             color: Colors.grey[900],
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//           iconTheme: IconThemeData(color: Colors.grey[900]),
//         ),
//         body: FutureBuilder<List<wird_night_morning>>(
//           future: wirdFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('خطأ: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return const Center(child: Text('لا توجد بيانات'));
//             } else {
//               return ListView.builder(
//                 padding: const EdgeInsets.all(12.0),
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final item = snapshot.data![index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             item.text,
//                             style: const TextStyle(fontSize: 16),
//                             textAlign: TextAlign.right,
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const SizedBox(), // Spacer for RTL
//                               IconButton(
//                                 icon: Icon(
//                                   isFavorite(item) ? Icons.favorite : Icons.favorite_border,
//                                   color: isFavorite(item) ? Colors.green : Colors.grey,
//                                 ),
//                                 onPressed: () => toggleFavorite(item),
//                               ),
//                             ],
//                           ),
//                           Text(
//                             'عدد التكرار: × ${item.counter}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }




// import 'package:aslamic_app/model/data_model.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
//
//
// class WirdMorningEveningPage extends StatefulWidget {
//   const WirdMorningEveningPage({super.key});
//
//   @override
//   State<WirdMorningEveningPage> createState() => _WirdMorningEveningPageState();
// }
//
// class _WirdMorningEveningPageState extends State<WirdMorningEveningPage> {
//   late Future<List<wird_night_morning>> wirdFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     wirdFuture = loadWird(context);
//   }
//
//   Future<List<wird_night_morning>> loadWird(BuildContext context) async {
//     final jsonStr = await DefaultAssetBundle.of(context).loadString('assets/db_json/wird_night_morning.json');
//     final List<dynamic> data = json.decode(jsonStr);
//     return data.map((json) => wird_night_morning.fromJson(json)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(  // اجعل الاتجاه من اليمين لليسار
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(title: const Text("أذكار الصباح والمساء"),
//         centerTitle: true,
//          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         ),
//         body: FutureBuilder<List<wird_night_morning>>(
//           future: wirdFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("خطأ: ${snapshot.error}"));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return const Center(child: Text("لا توجد بيانات"));
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final item = snapshot.data![index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     elevation: 3,
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             item.text,
//                             style: const TextStyle(fontSize: 16),
//                             textAlign: TextAlign.right,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "عدد التكرار: × ${item.counter}",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }