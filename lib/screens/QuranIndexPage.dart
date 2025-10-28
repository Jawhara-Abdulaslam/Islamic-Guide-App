import 'package:finalproject/model/app_state.dart';
import 'package:flutter/material.dart';
import 'quran_screen.dart';
import 'favorite.dart';

class QuranIndexPage extends StatefulWidget {
  @override
  _QuranIndexPageState createState() => _QuranIndexPageState();
}

class _QuranIndexPageState extends State<QuranIndexPage> {
  final List<String> surahNames = [
    "الفاتحة", "البقرة", "آل عمران", "النساء", "المائدة", "الأنعام",
    "الأعراف", "الأنفال", "التوبة", "يونس", "هود", "يوسف", "الرعد", "إبراهيم",
    "الحجر", "النحل", "الإسراء", "الكهف", "مريم", "طه", "الأنبياء", "الحج",
    "المؤمنون", "النور", "الفرقان", "الشعراء", "النمل", "القصص", "العنكبوت",
    "الروم", "لقمان", "السجدة", "الأحزاب", "سبأ", "فاطر", "يس", "الصافات",
    "ص", "الزمر", "غافر", "فصلت", "الشورى", "الزخرف", "الدخان", "الجاثية",
    "الأحقاف", "محمد", "الفتح", "الحجرات", "ق", "الذاريات", "الطور", "النجم",
    "القمر", "الرحمن", "الواقعة", "الحديد", "المجادلة", "الحشر", "الممتحنة",
    "الصف", "الجمعة", "المنافقون", "التغابن", "الطلاق", "التحريم", "الملك",
    "القلم", "الحاقة", "المعارج", "نوح", "الجن", "المزمل", "المدثر", "القيامة",
    "الإنسان", "المرسلات", "النبأ", "النازعات", "عبس", "التكوير", "الانفطار",
    "المطففين", "الانشقاق", "البروج", "الطارق", "الأعلى", "الغاشية", "الفجر",
    "البلد", "الشمس", "الليل", "الضحى", "الشرح", "التين", "العلق", "القدر",
    "البينة", "الزلزلة", "العاديات", "القارعة", "التكاثر", "العصر", "الهمزة",
    "الفيل", "قريش", "الماعون", "الكوثر", "الكافرون", "النصر", "المسد",
    "الإخلاص", "الفلق", "الناس",
  ];

  List<String> filteredSurahs = [];
  final TextEditingController _searchController = TextEditingController();
  List<String> favoriteSurahs = []; // غيرناها من final إلى عادية

  @override
  void initState() {
    super.initState();
    filteredSurahs = surahNames;
    _searchController.addListener(_filterSurahs);
    _loadFavorites();
  }

  void _loadFavorites() async {
    final favorites = await FavoriteManager.loadFavorites('surahs');
    setState(() {
      favoriteSurahs = favorites.cast<String>();
    });
  }

  void toggleFavorite(String surahName) async {
    setState(() {
      if (isFavorite(surahName)) {
        favoriteSurahs.remove(surahName);
      } else {
        favoriteSurahs.add(surahName);
      }
      // حفظ التغييرات
      FavoriteManager.saveAllFavorites(surahs: favoriteSurahs);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSurahs() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        filteredSurahs = surahNames;
      });
    } else {
      setState(() {
        filteredSurahs = surahNames.where((sura) {
          return _normalize(sura).contains(_normalize(query));
        }).toList();
      });
    }
  }

  /// دالة لتبسيط النص العربي (إزالة التشكيل وتوحيد الألف والهمزات)
  String _normalize(String input) {
    return input
        .replaceAll(RegExp(r'[ًٌٍَُِّْـ]'), '') // Remove tashkeel
        .replaceAll(RegExp(r'[إأآا]'), 'ا')     // Unify Alef
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .toLowerCase();
  }

  bool isFavorite(String surahName) {
    return favoriteSurahs.contains(surahName);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.topCenter,
            child: Text('السور'),
          ),
          backgroundColor: const Color(0xFF528777),
          // title: Directionality(
          //   textDirection: TextDirection.rtl,
          //   child: TextField(
          //     controller: _searchController,
          //     style: const TextStyle(color: Colors.white),
          //     cursorColor: Colors.white,
          //     decoration: const InputDecoration(
          //       hintText: 'ابحث باسم السورة',
          //       hintStyle: TextStyle(color: Colors.white70),
          //       border: InputBorder.none,
          //       prefixIcon: Icon(Icons.search, color: Colors.white),
          //     ),
          //   ),
          // ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FavoritesScreen(favoriteItems: favoriteSurahs),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: filteredSurahs.length,
            itemBuilder: (context, index) {
              final surahName = filteredSurahs[index];
              final originalIndex = surahNames.indexOf(surahName);
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  leading: Icon(Icons.menu_book_rounded, color: Colors.green[400], size: 28),
                  title: Text(
                    surahName,
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite(surahName) ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite(surahName) ? Colors.green : Colors.grey,
                    ),
                    onPressed: () => toggleFavorite(surahName),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuranPage(startIndex: originalIndex),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'quran_screen.dart';
// import 'favorite.dart';
//
// class QuranIndexPage extends StatefulWidget {
//   @override
//   _QuranIndexPageState createState() => _QuranIndexPageState();
// }
//
// class _QuranIndexPageState extends State<QuranIndexPage> {
//   final List<String> surahNames = [
//     "الفاتحة", "البقرة", "آل عمران", "النساء", "المائدة", "الأنعام",
//     "الأعراف", "الأنفال", "التوبة", "يونس", "هود", "يوسف", "الرعد", "إبراهيم",
//     "الحجر", "النحل", "الإسراء", "الكهف", "مريم", "طه", "الأنبياء", "الحج",
//     "المؤمنون", "النور", "الفرقان", "الشعراء", "النمل", "القصص", "العنكبوت",
//     "الروم", "لقمان", "السجدة", "الأحزاب", "سبأ", "فاطر", "يس", "الصافات",
//     "ص", "الزمر", "غافر", "فصلت", "الشورى", "الزخرف", "الدخان", "الجاثية",
//     "الأحقاف", "محمد", "الفتح", "الحجرات", "ق", "الذاريات", "الطور", "النجم",
//     "القمر", "الرحمن", "الواقعة", "الحديد", "المجادلة", "الحشر", "الممتحنة",
//     "الصف", "الجمعة", "المنافقون", "التغابن", "الطلاق", "التحريم", "الملك",
//     "القلم", "الحاقة", "المعارج", "نوح", "الجن", "المزمل", "المدثر", "القيامة",
//     "الإنسان", "المرسلات", "النبأ", "النازعات", "عبس", "التكوير", "الانفطار",
//     "المطففين", "الانشقاق", "البروج", "الطارق", "الأعلى", "الغاشية", "الفجر",
//     "البلد", "الشمس", "الليل", "الضحى", "الشرح", "التين", "العلق", "القدر",
//     "البينة", "الزلزلة", "العاديات", "القارعة", "التكاثر", "العصر", "الهمزة",
//     "الفيل", "قريش", "الماعون", "الكوثر", "الكافرون", "النصر", "المسد",
//     "الإخلاص", "الفلق", "الناس",
//   ];
//
//   List<String> filteredSurahs = [];
//   final TextEditingController _searchController = TextEditingController();
//   final List<String> favoriteSurahs = [];
//
//   @override
//   void initState() {
//     super.initState();
//     filteredSurahs = surahNames;
//     _searchController.addListener(_filterSurahs);
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void _filterSurahs() {
//     final query = _searchController.text.trim();
//     if (query.isEmpty) {
//       setState(() {
//         filteredSurahs = surahNames;
//       });
//     } else {
//       setState(() {
//         filteredSurahs = surahNames.where((sura) {
//           return _normalize(sura).contains(_normalize(query));
//         }).toList();
//       });
//     }
//   }
//
//   /// دالة لتبسيط النص العربي (إزالة التشكيل وتوحيد الألف والهمزات)
//   String _normalize(String input) {
//     return input
//         .replaceAll(RegExp(r'[ًٌٍَُِّْـ]'), '') // Remove tashkeel
//         .replaceAll(RegExp(r'[إأآا]'), 'ا')     // Unify Alef
//         .replaceAll('ة', 'ه')
//         .replaceAll('ى', 'ي')
//         .toLowerCase();
//   }
//
//   bool isFavorite(String surahName) {
//     return favoriteSurahs.contains(surahName);
//   }
//
//   void toggleFavorite(String surahName) {
//     setState(() {
//       if (isFavorite(surahName)) {
//         favoriteSurahs.remove(surahName);
//       } else {
//         favoriteSurahs.add(surahName);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF528777),
//           title: Directionality(
//             textDirection: TextDirection.rtl,
//             child: TextField(
//               controller: _searchController,
//               style: const TextStyle(color: Colors.white),
//               cursorColor: Colors.white,
//               decoration: const InputDecoration(
//                 hintText: 'ابحث باسم السورة',
//                 hintStyle: TextStyle(color: Colors.white70),
//                 border: InputBorder.none,
//                 prefixIcon: Icon(Icons.search, color: Colors.white),
//               ),
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.favorite),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => FavoritesScreen(favoriteItems: favoriteSurahs),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: ListView.builder(
//             itemCount: filteredSurahs.length,
//             itemBuilder: (context, index) {
//               final surahName = filteredSurahs[index];
//               final originalIndex = surahNames.indexOf(surahName);
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   leading: Icon(Icons.menu_book_rounded, color: Colors.green[400], size: 28),
//                   title: Text(
//                     surahName,
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                   trailing: IconButton(
//                     icon: Icon(
//                       isFavorite(surahName) ? Icons.favorite : Icons.favorite_border,
//                       color: isFavorite(surahName) ? Colors.green : Colors.grey,
//                     ),
//                     onPressed: () => toggleFavorite(surahName),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => QuranPage(startIndex: originalIndex),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


