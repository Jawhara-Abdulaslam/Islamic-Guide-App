class allah_names {
  final String name;
  final String text;

  allah_names({required this.name, required this.text});

  static allah_names fromJson(json) => allah_names(
    name: json['name'],
    text: json['text'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is allah_names &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              text == other.text;

  @override
  int get hashCode => name.hashCode ^ text.hashCode;
}

class hisnulmuslim {
  final String title;
  final String reference;
  final String arabic;
  final String english;

  hisnulmuslim({
    required this.title,
    required this.reference,
    required this.arabic,
    required this.english,
  });

  static hisnulmuslim fromJson(json) => hisnulmuslim(
    title: json['title'],
    reference: json['reference'],
    arabic: json['arabic'],
    english: json['english'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is hisnulmuslim &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              reference == other.reference &&
              arabic == other.arabic &&
              english == other.english;

  @override
  int get hashCode =>
      title.hashCode ^ reference.hashCode ^ arabic.hashCode ^ english.hashCode;
}

class QuranSurah {
  final int chapter;
  final List<Quran> verses;

  QuranSurah({
    required this.chapter,
    required this.verses,
  });
}

class Quran {
  final int chapter;
  final int verse;
  final String text;

  Quran({required this.chapter, required this.verse, required this.text});

  factory Quran.fromJson(Map<String, dynamic> json) {
    return Quran(
      chapter: json['chapter'],
      verse: json['verse'],
      text: json['text'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Quran &&
              runtimeType == other.runtimeType &&
              chapter == other.chapter &&
              verse == other.verse &&
              text == other.text;

  @override
  int get hashCode => chapter.hashCode ^ verse.hashCode ^ text.hashCode;
}

class wird_night_morning {
  final String text;
  final int counter;

  wird_night_morning({required this.text, required this.counter});

  static wird_night_morning fromJson(json) => wird_night_morning(
    text: json['text'],
    counter: json['counter'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is wird_night_morning &&
              runtimeType == other.runtimeType &&
              text == other.text &&
              counter == other.counter;

  @override
  int get hashCode => text.hashCode ^ counter.hashCode;
}

class zkar_after_pray {
  final String zekr;
  final int repeat;
  final String? bless;

  zkar_after_pray({required this.zekr, required this.repeat, this.bless});

  static zkar_after_pray fromJson(json) => zkar_after_pray(
    zekr: json['zekr'],
    repeat: json['repeat'],
    bless: json['bless'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is zkar_after_pray &&
              runtimeType == other.runtimeType &&
              zekr == other.zekr &&
              repeat == other.repeat &&
              bless == other.bless;

  @override
  int get hashCode => zekr.hashCode ^ repeat.hashCode ^ (bless?.hashCode ?? 0);
}

class Item {
  final int id;
  final String name;
  final String type;

  Item({required this.id, required this.name, required this.type});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Item &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              type == other.type;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ type.hashCode;
}





//
// // models/favorite_model.dart
// class FavoriteItem {
//   final String id;
//   final String title;
//   final String description;
//   final String imageUrl;
//   final String pageType; // نوع الصفحة (مثل: قرآن، أدعية، إلخ)
//
//   FavoriteItem({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     required this.pageType,
//   });
//
//   // تحويل إلى Map لحفظه في SharedPreferences
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'imageUrl': imageUrl,
//       'pageType': pageType,
//     };
//   }
//
//   // تحويل من Map إلى FavoriteItem
//   factory FavoriteItem.fromMap(Map<String, dynamic> map) {
//     return FavoriteItem(
//       id: map['id'],
//       title: map['title'],
//       description: map['description'],
//       imageUrl: map['imageUrl'],
//       pageType: map['pageType'],
//     );
//   }
// }

//
// class allah_names{
//   final String name;
//   final String text;
//
//   allah_names({required this.name ,required this.text});
//
//   static allah_names fromJson(json) => allah_names (
//     name: json['name'], text: json['text'],
//   );
//
//   static void initState() {}
//
// }
//
// class hisnulmuslim{
//   final String title;
//   final String reference;
//   final String arabic;
//   final String english;
//
//   hisnulmuslim({required this.title ,required this.reference ,required this.arabic ,required this.english});
//
//   static hisnulmuslim fromJson(json) => hisnulmuslim (
//     title: json['title'], reference: json['reference'],
//     arabic: json['arabic'], english: json['english'],
//   );
//
// }
//
//
//
// class QuranSurah {
//   final int chapter;
//   final List<Quran> verses;
//
//   QuranSurah({
//     required this.chapter,
//     required this.verses,
//   });
// }
//
// class Quran {
//   final int chapter;
//   final int verse;
//   final String text;
//
//   Quran({required this.chapter, required this.verse, required this.text});
//
//   factory Quran.fromJson(Map<String, dynamic> json) {
//     return Quran(
//       chapter: json['chapter'],
//       verse: json['verse'],
//       text: json['text'],
//     );
//   }
// }
//
//
//
// // class Quran{
// //   final int chapter;
// //   final int verse;
// //   final String text;
// //
// //   Quran({required this.chapter ,required this.verse,required this.text});
// //
// //   static Quran fromJson(json) => Quran (
// //     chapter: json['chapter'], verse: json['verse'],
// //     text: json['text'],
// //   );
// //
// // }
//
// class wird_night_morning{
//   final String text;
//   final int counter;
//
//   wird_night_morning({required this.text ,required this.counter});
//
//   static wird_night_morning fromJson(json) => wird_night_morning (
//     text: json['text'], counter: json['counter'],
//   );
//
// }
//
//
// class zkar_after_pray{
//   // final int id;
//   final String zekr;
//   final int repeat;
//   final String? bless;
//
//   zkar_after_pray({required this.zekr,required this.repeat,this.bless});
//
//   // static zkar_after_pray fromJson(Map<String, dynamic> json, int id) => zkar_after_pray(
//     // id: id,
//   static zkar_after_pray fromJson(json) => zkar_after_pray (
//     zekr: json['zekr'],
//     repeat: json['repeat'],
//     bless: json['bless'],
//   );
//   // static zkar_after_pray fromJson(json) => zkar_after_pray (
//   //   zekr: json['zekr'], repeat: json['repeat'],
//   //   bless: json['bless'],
//
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is zkar_after_pray &&
//               runtimeType == other.runtimeType &&
//               zekr == other.zekr &&
//               repeat == other.repeat &&
//               bless == other.bless;
//
//   @override
//   int get hashCode => zekr.hashCode ^ repeat.hashCode ^ (bless?.hashCode ?? 0);
// }
//
// class Item {
//   final int id;
//   final String name;
//   final String type;
//
//   Item({required this.id, required this.name, required this.type});
// }


