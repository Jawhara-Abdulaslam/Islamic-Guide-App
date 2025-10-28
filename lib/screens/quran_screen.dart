import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/QuranIndexPage.dart';


class QuranPage extends StatefulWidget {
  final int startIndex; // <-- نضيف هذه

  const QuranPage({Key? key, this.startIndex = 0});

  @override
  State<QuranPage> createState() {
    return _QuranPageState();
  }
}

class _QuranPageState extends State<QuranPage> {
  late Future<List<QuranSurah>> quranFuture;
  late PageController _pageController = PageController();
  // int _currentSurahIndex = 0;
  late int _currentSurahIndex;
  double _fontSize = 22.0;

  @override
  void initState() {
    super.initState();
    quranFuture = loadQuran();
    _currentSurahIndex = widget.startIndex;
    _pageController = PageController(initialPage: _currentSurahIndex);
  }

  Future<List<QuranSurah>> loadQuran() async {
    final jsonStr = await rootBundle.loadString('assets/db_json/Quran.json');
    final Map<String, dynamic> jsonData = json.decode(jsonStr);

    List<QuranSurah> surahs = [];
    jsonData.forEach((key, value) {
      final int surahNumber = int.parse(key);
      final List verses = value;
      surahs.add(
        QuranSurah(
          chapter: surahNumber,
          verses: verses.map((v) => Quran.fromJson(v)).toList(),
        ),
      );
    });

    surahs.sort((a, b) => a.chapter.compareTo(b.chapter));
    return surahs;
  }

  void _increaseFont() {
    setState(() {
      if (_fontSize < 40) _fontSize += 2;
    });
  }

  void _decreaseFont() {
    setState(() {
      if (_fontSize > 12) _fontSize -= 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F1EB),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // 🔙 يرجع للفهرس
            },
          ),
          title: Align(
            alignment: Alignment.topCenter,
            child: Text('القرآن الكريم'),
          ),
          backgroundColor: const Color(0xFF528777),
          centerTitle: true,
          elevation: 1,
          titleTextStyle: TextStyle(
            color: Colors.grey[900],
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          iconTheme: IconThemeData(color: Colors.grey[900]),
        ),
        body: FutureBuilder<List<QuranSurah>>(
          future: quranFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("خطأ: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("لا توجد بيانات"));
            } else {
              final surahs = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: surahs.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentSurahIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final surah = surahs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    'سورة ${surahNames[index]}',
                                    style: TextStyle(
                                      fontSize: _fontSize + 6,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[850],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                if (surah.chapter != 9)
                                  Text(
                                    'بسم الله الرحمن الرحيم',
                                    style: TextStyle(
                                      fontSize: _fontSize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[900],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                if (surah.chapter != 9) const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    surah.verses
                                        .map((v) => '${v.text}﴿${v.verse}﴾')
                                        .join(' '),
                                    style: TextStyle(
                                      fontSize: _fontSize,
                                      height: 1.5,
                                      color: Colors.grey[900],
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _decreaseFont,
                          icon: const Icon(Icons.remove),
                          tooltip: 'تصغير الخط',
                          color: Colors.grey[700],
                        ),
                        Text(
                          'حجم الخط: ${_fontSize.toInt()}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          onPressed: _increaseFont,
                          icon: const Icon(Icons.add),
                          tooltip: 'تكبير الخط',
                          color: Colors.grey[700],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'سورة رقم ${surahs[_currentSurahIndex].chapter}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                ],
              );
            }
          },
        ),
      ),
    );
  }
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
}

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