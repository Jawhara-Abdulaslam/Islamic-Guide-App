import 'dart:convert';
import 'package:finalproject/model/app_state.dart';
import 'package:finalproject/screens/favorite.dart';
import '../model/model.dart';
import 'package:flutter/material.dart';

class ZkarAfterPrayPage extends StatefulWidget {
  const ZkarAfterPrayPage({super.key});

  @override
  State<ZkarAfterPrayPage> createState() => _ZkarAfterPrayPageState();
}

class _ZkarAfterPrayPageState extends State<ZkarAfterPrayPage> {
  late Future<List<zkar_after_pray>> zekrFuture;
  List<zkar_after_pray> favoriteZekrList = [];

  @override
  void initState() {
    super.initState();
    zekrFuture = loadZekr(context);
    _loadFavorites();
  }

  void _loadFavorites() async {
    final favorites = await FavoriteManager.loadFavorites('zkar_after_pray');
    setState(() {
      favoriteZekrList = favorites.cast<zkar_after_pray>();
    });
  }

  Future<List<zkar_after_pray>> loadZekr(BuildContext context) async {
    final jsonStr =
    await DefaultAssetBundle.of(context).loadString('assets/db_json/zkar-after-pray.json');
    final List<dynamic> data = json.decode(jsonStr);
    return data.map((json) => zkar_after_pray.fromJson(json)).toList();
  }

  bool isFavorite(zkar_after_pray item) {
    return favoriteZekrList.any((fav) => fav.zekr == item.zekr);
  }

  void toggleFavorite(zkar_after_pray item) {
    setState(() {
      if (isFavorite(item)) {
        favoriteZekrList.removeWhere((fav) => fav.zekr == item.zekr);
      } else {
        favoriteZekrList.add(item);
      }
      // حفظ التغييرات - نمرر القائمة كـ nullable
      FavoriteManager.saveAllFavorites(zkarAfterPray: []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F1EB),
        appBar: AppBar(
          backgroundColor: const Color(0xFF528777),
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.grey[900]),
          title: const Text(
            'أذكار بعد الصلاة',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FavoritesScreen(favoriteItems: favoriteZekrList),
                  ),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<zkar_after_pray>>(
          future: zekrFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('خطأ: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('لا توجد بيانات'));
            } else {
              final items = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(12.0),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
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
                            item.zekr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(), // Spacer for RTL
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
                            'عدد التكرار: ${item.repeat}',
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'الفضل: ${item.bless}',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
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

// import 'dart:convert';
// import 'package:finalproject/screens/favorite.dart';
//
// import '../model/model.dart';
// import 'package:flutter/material.dart';
//
//
// class ZkarAfterPrayPage extends StatefulWidget {
//   const ZkarAfterPrayPage({super.key});
//
//   @override
//   State<ZkarAfterPrayPage> createState() => _ZkarAfterPrayPageState();
// }
//
// class _ZkarAfterPrayPageState extends State<ZkarAfterPrayPage> {
//   late Future<List<zkar_after_pray>> zekrFuture;
//   final List<zkar_after_pray> favoriteZekrList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     zekrFuture = loadZekr(context);
//   }
//
//   Future<List<zkar_after_pray>> loadZekr(BuildContext context) async {
//     final jsonStr =
//     await DefaultAssetBundle.of(context).loadString('assets/db_json/zkar-after-pray.json');
//     final List<dynamic> data = json.decode(jsonStr);
//     return data.map((json) => zkar_after_pray.fromJson(json)).toList();
//   }
//
//   bool isFavorite(zkar_after_pray item) {
//     return favoriteZekrList.any((fav) => fav.zekr == item.zekr);
//   }
//
//   void toggleFavorite(zkar_after_pray item) {
//     setState(() {
//       if (isFavorite(item)) {
//         favoriteZekrList.removeWhere((fav) => fav.zekr == item.zekr);
//       } else {
//         favoriteZekrList.add(item);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F1EB),
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF528777),
//           elevation: 1,
//           iconTheme: IconThemeData(color: Colors.grey[900]),
//           title: const Text(
//             'أذكار بعد الصلاة',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.favorite),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => FavoritesScreen(favoriteItems: favoriteZekrList),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: FutureBuilder<List<zkar_after_pray>>(
//           future: zekrFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('خطأ: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return const Center(child: Text('لا توجد بيانات'));
//             } else {
//               final items = snapshot.data!;
//               return ListView.builder(
//                 padding: const EdgeInsets.all(12.0),
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   final item = items[index];
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
//                             item.zekr,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
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
//                             'عدد التكرار: ${item.repeat}',
//                             style: const TextStyle(fontSize: 16),
//                             textAlign: TextAlign.right,
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'الفضل: ${item.bless}',
//                             style: const TextStyle(fontSize: 14, color: Colors.grey),
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
