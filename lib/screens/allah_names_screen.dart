import 'dart:convert';
import 'package:finalproject/screens/favorite.dart';
import '../model/model.dart';
import 'package:flutter/material.dart';

class AllahNamesScreen extends StatefulWidget {
  const AllahNamesScreen({super.key});

  @override
  State<AllahNamesScreen> createState() => _AllahNamesScreenState();
}

class _AllahNamesScreenState extends State<AllahNamesScreen> {
  late Future<List<allah_names>> allahNamesFuture;
  final List<allah_names> favoriteNamesList = [];

  @override
  void initState() {
    super.initState();
    allahNamesFuture = getAllahNames(context);
  }

  Future<List<allah_names>> getAllahNames(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/db_json/allah_names.json');
    final decoded = json.decode(data);

    if (decoded is List) {
      return decoded.map((json) => allah_names.fromJson(json)).toList();
    } else if (decoded is Map && decoded['names'] is List) {
      return (decoded['names'] as List)
          .map((json) => allah_names.fromJson(json))
          .toList();
    } else {
      throw Exception('البيانات غير متوقعة: ${decoded.runtimeType}');
    }
  }

  bool isFavorite(allah_names item) {
    return favoriteNamesList.any((fav) => fav.name == item.name);
  }

  void toggleFavorite(allah_names item) {
    setState(() {
      if (isFavorite(item)) {
        favoriteNamesList.removeWhere((fav) => fav.name == item.name);
      } else {
        favoriteNamesList.add(item);
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
            child: Text('أسماء الله الحسنى'),
          ),
          backgroundColor: const Color(0xFF528777),
          elevation: 1,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          iconTheme: IconThemeData(color: Colors.grey[900]),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FavoritesScreen(favoriteItems: favoriteNamesList),
                  ),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<allah_names>>(
          future: allahNamesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('حدث خطأ: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('لا توجد بيانات'));
            } else {
              return _buildNamesList(snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Widget _buildNamesList(List<allah_names> names) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: names.length,
      itemBuilder: (context, index) {
        final name = names[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.brown[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite(name) ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite(name) ? Colors.green : Colors.grey,
                      ),
                      onPressed: () => toggleFavorite(name),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  name.text,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// import 'dart:convert';
// import '../model/model.dart';
// import 'package:flutter/material.dart';
//
// class AllahNamesScreen extends StatefulWidget {
//   const AllahNamesScreen({super.key});
//
//   @override
//   State<AllahNamesScreen> createState() => _AllahNamesScreenState();
// }
//
// class _AllahNamesScreenState extends State<AllahNamesScreen> {
//   late Future<List<allah_names>> allahNamesFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     allahNamesFuture = getAllahNames(context);
//   }
//
//   Future<List<allah_names>> getAllahNames(BuildContext context) async {
//     final assetBundle = DefaultAssetBundle.of(context);
//     final data = await assetBundle.loadString('assets/db_json/allah_names.json');
//     final decoded = json.decode(data);
//
//     if (decoded is List) {
//       return decoded.map((json) => allah_names.fromJson(json)).toList();
//     } else if (decoded is Map && decoded['names'] is List) {
//       return (decoded['names'] as List)
//           .map((json) => allah_names.fromJson(json))
//           .toList();
//     } else {
//       throw Exception('البيانات غير متوقعة: ${decoded.runtimeType}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F1EB),
//         appBar: AppBar(
//           title: Align(
//             alignment: Alignment.topCenter,
//             child: Text('أسماء الله الحسنى'),
//
//           ),
//           backgroundColor: const Color(0xFF528777),
//           elevation: 1,
//           titleTextStyle: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//           iconTheme: IconThemeData(color: Colors.grey[900]),
//         ),
//         body: FutureBuilder<List<allah_names>>(
//           future: allahNamesFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('حدث خطأ: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return const Center(child: Text('لا توجد بيانات'));
//             } else {
//               return _buildNamesList(snapshot.data!);
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNamesList(List<allah_names> names) {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       itemCount: names.length,
//       itemBuilder: (context, index) {
//         final name = names[index];
//
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 6),
//           elevation: 3,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   name.name,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                     color: Colors.brown[700],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   name.text,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     height: 1.6,
//                     color: Colors.black87,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }