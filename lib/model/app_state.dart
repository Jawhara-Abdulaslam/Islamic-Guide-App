import 'dart:convert';

import 'package:finalproject/model/model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  // حالة المستخدم
  bool _isLoggedIn = false;
  String? _username;

  // الوضع الليلي
  bool _isDarkMode = false;

  // قائمة المفضلة
  List<String> _favorites = [];

  // تتبع قراءة القرآن
  int _quranProgress = 0; // نسبة مئوية 0-100
  int _currentSurah = 1;  // رقم السورة الحالية

  // تذكيرات الصلاة
  bool _prayerRemindersEnabled = false;
  Map<String, String> _prayerTimes = {
    'Fajr': '05:00',
    'Dhuhr': '12:30',
    'Asr': '15:45',
    'Maghrib': '18:20',
    'Isha': '19:45',
  };

  // تخطيط الصفحة الرئيسية (Home Layout)
  HomeLayout _homeLayout = HomeLayout.grid; // الافتراضي Grid
  int _homeGridCrossAxisCount = 2; // عدد الأعمدة في Grid
  double _homeCardAspectRatio = 0.8; // نسبة العرض إلى الارتفاع للبطاقات
  bool _showFavoritesOnly = false; // عرض المفضلة فقط

  // مفاتيح التخزين
  static const String _darkModeKey = 'is_dark_mode';
  static const String _favoritesKey = 'favorites';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _usernameKey = 'username';
  static const String _quranProgressKey = 'quran_progress';
  static const String _currentSurahKey = 'current_surah';
  static const String _prayerRemindersKey = 'prayer_reminders_enabled';
  static const String _prayerTimesKey = 'prayer_times';
  static const String _homeLayoutKey = 'home_layout';
  static const String _homeGridCrossAxisCountKey = 'home_grid_cross_axis_count';
  static const String _homeCardAspectRatioKey = 'home_card_aspect_ratio';
  static const String _showFavoritesOnlyKey = 'show_favorites_only';

  // Getters
  bool get isLoggedIn => _isLoggedIn;
  String? get username => _username;
  bool get isDarkMode => _isDarkMode;
  List<String> get favorites => List.unmodifiable(_favorites);
  int get quranProgress => _quranProgress;
  int get currentSurah => _currentSurah;
  bool get prayerRemindersEnabled => _prayerRemindersEnabled;
  Map<String, String> get prayerTimes => Map.unmodifiable(_prayerTimes);
  HomeLayout get homeLayout => _homeLayout;
  int get homeGridCrossAxisCount => _homeGridCrossAxisCount;
  double get homeCardAspectRatio => _homeCardAspectRatio;
  bool get showFavoritesOnly => _showFavoritesOnly;

  // تحميل الحالة من التخزين
  Future<void> loadInitialState() async {
    final prefs = await SharedPreferences.getInstance();

    _isDarkMode = prefs.getBool(_darkModeKey) ?? false;
    _favorites = prefs.getStringList(_favoritesKey) ?? [];
    _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    _username = prefs.getString(_usernameKey);
    _quranProgress = prefs.getInt(_quranProgressKey) ?? 0;
    _currentSurah = prefs.getInt(_currentSurahKey) ?? 1;
    _prayerRemindersEnabled = prefs.getBool(_prayerRemindersKey) ?? false;

    // تحميل إعدادات تخطيط الصفحة الرئيسية
    _homeLayout = HomeLayout.values[prefs.getInt(_homeLayoutKey) ?? HomeLayout.grid.index];
    _homeGridCrossAxisCount = prefs.getInt(_homeGridCrossAxisCountKey) ?? 2;
    _homeCardAspectRatio = prefs.getDouble(_homeCardAspectRatioKey) ?? 0.8;
    _showFavoritesOnly = prefs.getBool(_showFavoritesOnlyKey) ?? false;

    // تحميل أوقات الصلاة (مخزنة كسلسلة JSON)
    final prayerTimesString = prefs.getString(_prayerTimesKey);
    if (prayerTimesString != null) {
      try {
        final Map<String, dynamic> decoded = Map<String, dynamic>.from(
            Uri.splitQueryString(prayerTimesString)
        );
        _prayerTimes = decoded.map((key, value) => MapEntry(key, value.toString()));
      } catch (_) {
        // إذا فشل التحميل، نستخدم القيم الافتراضية
      }
    }

    notifyListeners();
  }

  // تسجيل الدخول
  Future<void> login(String username) async {
    if (username.isEmpty) {
      throw Exception('اسم المستخدم لا يمكن أن يكون فارغاً');
    }
    _isLoggedIn = true;
    _username = username;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_usernameKey, username);

    notifyListeners();
  }

  // تسجيل الخروج
  Future<void> logout({bool clearFavorites = false}) async {
    _isLoggedIn = false;
    _username = null;

    if (clearFavorites) {
      _favorites.clear();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_favoritesKey);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_usernameKey);

    notifyListeners();
  }

  // تبديل الوضع الليلي
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, _isDarkMode);

    notifyListeners();
  }

  // المفضلة
  Future<void> addToFavorites(String itemId) async {
    if (!_favorites.contains(itemId)) {
      _favorites.add(itemId);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_favoritesKey, _favorites);

      notifyListeners();
    }
  }

  Future<void> removeFromFavorites(String itemId) async {
    if (_favorites.contains(itemId)) {
      _favorites.remove(itemId);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_favoritesKey, _favorites);

      notifyListeners();
    }
  }

  bool isFavorite(String itemId) {
    return _favorites.contains(itemId);
  }

  // تحديث تقدم قراءة القرآن
  Future<void> updateQuranProgress(int progress) async {
    _quranProgress = progress.clamp(0, 100);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_quranProgressKey, _quranProgress);

    notifyListeners();
  }

  // تحديث السورة الحالية
  Future<void> updateCurrentSurah(int surahNumber) async {
    if (surahNumber < 1) return;
    _currentSurah = surahNumber;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_currentSurahKey, _currentSurah);

    notifyListeners();
  }

  // تفعيل/تعطيل تذكيرات الصلاة
  Future<void> togglePrayerReminders() async {
    _prayerRemindersEnabled = !_prayerRemindersEnabled;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prayerRemindersKey, _prayerRemindersEnabled);

    notifyListeners();
  }

  // تحديث أوقات الصلاة (مثلاً من API أو إعدادات المستخدم)
  Future<void> updatePrayerTimes(Map<String, String> newTimes) async {
    _prayerTimes = Map.from(newTimes);

    final prefs = await SharedPreferences.getInstance();
    // حفظ كـ query string (مثلاً: Fajr=05:00&Dhuhr=12:30...)
    final encoded = Uri(queryParameters: _prayerTimes).query;
    await prefs.setString(_prayerTimesKey, encoded);

    notifyListeners();
  }

  // === إعدادات تخطيط الصفحة الرئيسية ===

  // تغيير تخطيط الصفحة الرئيسية
  Future<void> changeHomeLayout(HomeLayout layout) async {
    _homeLayout = layout;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_homeLayoutKey, layout.index);

    notifyListeners();
  }

  // تبديل تخطيط الصفحة الرئيسية
  Future<void> toggleHomeLayout() async {
    _homeLayout = _homeLayout == HomeLayout.grid
        ? HomeLayout.list
        : HomeLayout.grid;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_homeLayoutKey, _homeLayout.index);

    notifyListeners();
  }

  // تحديث عدد الأعمدة في Grid
  Future<void> updateGridCrossAxisCount(int count) async {
    if (count < 1 || count > 4) return; // تحديد نطاق معقول

    _homeGridCrossAxisCount = count;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_homeGridCrossAxisCountKey, count);

    notifyListeners();
  }

  // تحديث نسبة العرض إلى الارتفاع للبطاقات
  Future<void> updateCardAspectRatio(double ratio) async {
    if (ratio < 0.5 || ratio > 2.0) return; // تحديد نطاق معقول

    _homeCardAspectRatio = ratio;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_homeCardAspectRatioKey, ratio);

    notifyListeners();
  }

  // تبديل عرض المفضلة فقط
  Future<void> toggleShowFavoritesOnly() async {
    _showFavoritesOnly = !_showFavoritesOnly;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showFavoritesOnlyKey, _showFavoritesOnly);

    notifyListeners();
  }

  // الحصول على قائمة العناصر المفضلة فقط
  List<String> getFilteredItems(List<String> allItems) {
    if (_showFavoritesOnly) {
      return allItems.where((item) => _favorites.contains(item)).toList();
    }
    return allItems;
  }

  // إعادة تعيين إعدادات التخطيط إلى الافتراضية
  Future<void> resetLayoutSettings() async {
    _homeLayout = HomeLayout.grid;
    _homeGridCrossAxisCount = 2;
    _homeCardAspectRatio = 0.8;
    _showFavoritesOnly = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_homeLayoutKey, _homeLayout.index);
    await prefs.setInt(_homeGridCrossAxisCountKey, _homeGridCrossAxisCount);
    await prefs.setDouble(_homeCardAspectRatioKey, _homeCardAspectRatio);
    await prefs.setBool(_showFavoritesOnlyKey, _showFavoritesOnly);

    notifyListeners();
  }
}

// أنواع التخطيط المتاحة للصفحة الرئيسية
enum HomeLayout {
  grid,    // شبكة
  list,    // قائمة
}

// -------------------------------------------------------------
// المفضله
// -------------------------------------------------------------


class FavoriteManager {
  static const String _favoriteKey = 'favorite_items';

  // حفظ جميع أنواع المفضلة
  static Future<void> saveAllFavorites({
    List<zkar_after_pray>? zkarAfterPray,
    List<wird_night_morning>? wirdMorning,
    List<hisnulmuslim>? hisnulMuslim,
    List<allah_names>? allahNames,
    List<String>? surahs,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> allFavorites = {};

    if (zkarAfterPray != null) {
      allFavorites['zkar_after_pray'] = zkarAfterPray.map((item) => _convertZkarToMap(item)).toList();
    }

    if (wirdMorning != null) {
      allFavorites['wird_morning'] = wirdMorning.map((item) => _convertWirdToMap(item)).toList();
    }

    if (hisnulMuslim != null) {
      allFavorites['hisnul_muslim'] = hisnulMuslim.map((item) => _convertHisnulToMap(item)).toList();
    }

    if (allahNames != null) {
      allFavorites['allah_names'] = allahNames.map((item) => _convertAllahNameToMap(item)).toList();
    }

    if (surahs != null) {
      allFavorites['surahs'] = surahs;
    }

    await prefs.setString(_favoriteKey, json.encode(allFavorites));
  }

  // تحميل جميع المفضلات
  static Future<Map<String, dynamic>> loadAllFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoriteData = prefs.getString(_favoriteKey);

    if (favoriteData == null) {
      return {};
    }

    try {
      return json.decode(favoriteData);
    } catch (e) {
      return {};
    }
  }

  // تحميل مفضلة محددة
  static Future<List<dynamic>> loadFavorites(String type) async {
    final allFavorites = await loadAllFavorites();

    switch (type) {
      case 'zkar_after_pray':
        final data = allFavorites['zkar_after_pray'] as List?;
        return data?.map((map) => _convertMapToZkar(map)).toList() ?? [];
      case 'wird_morning':
        final data = allFavorites['wird_morning'] as List?;
        return data?.map((map) => _convertMapToWird(map)).toList() ?? [];
      case 'hisnul_muslim':
        final data = allFavorites['hisnul_muslim'] as List?;
        return data?.map((map) => _convertMapToHisnul(map)).toList() ?? [];
      case 'allah_names':
        final data = allFavorites['allah_names'] as List?;
        return data?.map((map) => _convertMapToAllahName(map)).toList() ?? [];
      case 'surahs':
        return allFavorites['surahs'] as List? ?? [];
      default:
        return [];
    }
  }

  // دوال التحويل لـ zkar_after_pray
  static Map<String, dynamic> _convertZkarToMap(zkar_after_pray item) {
    return {
      'zekr': item.zekr,
      'repeat': item.repeat,
      'bless': item.bless,
    };
  }

  static zkar_after_pray _convertMapToZkar(Map<String, dynamic> map) {
    return zkar_after_pray(
      zekr: map['zekr'] ?? '',
      repeat: map['repeat'] ?? 0,
      bless: map['bless'],
    );
  }

  // دوال التحويل لـ wird_night_morning
  static Map<String, dynamic> _convertWirdToMap(wird_night_morning item) {
    return {
      'text': item.text,
      'counter': item.counter,
    };
  }

  static wird_night_morning _convertMapToWird(Map<String, dynamic> map) {
    return wird_night_morning(
      text: map['text'] ?? '',
      counter: map['counter'] ?? 0,
    );
  }

  // دوال التحويل لـ hisnulmuslim
  static Map<String, dynamic> _convertHisnulToMap(hisnulmuslim item) {
    return {
      'title': item.title,
      'arabic': item.arabic,
      'english': item.english,
      'reference': item.reference,
    };
  }

  static hisnulmuslim _convertMapToHisnul(Map<String, dynamic> map) {
    return hisnulmuslim(
      title: map['title'] ?? '',
      reference: map['reference'] ?? '',
      arabic: map['arabic'] ?? '',
      english: map['english'] ?? '',
    );
  }

  // دوال التحويل لـ allah_names
  static Map<String, dynamic> _convertAllahNameToMap(allah_names item) {
    return {
      'name': item.name,
      'text': item.text,
    };
  }

  static allah_names _convertMapToAllahName(Map<String, dynamic> map) {
    return allah_names(
      name: map['name'] ?? '',
      text: map['text'] ?? '',
    );
  }

  // مسح كل المفضلة
  static Future<void> clearAllFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoriteKey);
  }
}

// ------------------------------------------------------------


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AppState extends ChangeNotifier {
//   // حالة المستخدم
//   bool _isLoggedIn = false;
//   String? _username;
//
//   // الوضع الليلي
//   bool _isDarkMode = false;
//
//   // قائمة المفضلة
//   List<String> _favorites = [];
//
//   // تتبع قراءة القرآن
//   int _quranProgress = 0; // نسبة مئوية 0-100
//   int _currentSurah = 1;  // رقم السورة الحالية
//
//   // تذكيرات الصلاة
//   bool _prayerRemindersEnabled = false;
//   Map<String, String> _prayerTimes = {
//     'Fajr': '05:00',
//     'Dhuhr': '12:30',
//     'Asr': '15:45',
//     'Maghrib': '18:20',
//     'Isha': '19:45',
//   };
//
//   // مفاتيح التخزين
//   static const String _darkModeKey = 'is_dark_mode';
//   static const String _favoritesKey = 'favorites';
//   static const String _isLoggedInKey = 'is_logged_in';
//   static const String _usernameKey = 'username';
//   static const String _quranProgressKey = 'quran_progress';
//   static const String _currentSurahKey = 'current_surah';
//   static const String _prayerRemindersKey = 'prayer_reminders_enabled';
//   static const String _prayerTimesKey = 'prayer_times';
//
//   // Getters
//   bool get isLoggedIn => _isLoggedIn;
//   String? get username => _username;
//   bool get isDarkMode => _isDarkMode;
//   List<String> get favorites => List.unmodifiable(_favorites);
//   int get quranProgress => _quranProgress;
//   int get currentSurah => _currentSurah;
//   bool get prayerRemindersEnabled => _prayerRemindersEnabled;
//   Map<String, String> get prayerTimes => Map.unmodifiable(_prayerTimes);
//
//   // تحميل الحالة من التخزين
//   Future<void> loadInitialState() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     _isDarkMode = prefs.getBool(_darkModeKey) ?? false;
//     _favorites = prefs.getStringList(_favoritesKey) ?? [];
//     _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
//     _username = prefs.getString(_usernameKey);
//     _quranProgress = prefs.getInt(_quranProgressKey) ?? 0;
//     _currentSurah = prefs.getInt(_currentSurahKey) ?? 1;
//     _prayerRemindersEnabled = prefs.getBool(_prayerRemindersKey) ?? false;
//
//     // تحميل أوقات الصلاة (مخزنة كسلسلة JSON)
//     final prayerTimesString = prefs.getString(_prayerTimesKey);
//     if (prayerTimesString != null) {
//       try {
//         final Map<String, dynamic> decoded = Map<String, dynamic>.from(
//             Uri.splitQueryString(prayerTimesString)
//         );
//         _prayerTimes = decoded.map((key, value) => MapEntry(key, value.toString()));
//       } catch (_) {
//         // إذا فشل التحميل، نستخدم القيم الافتراضية
//       }
//     }
//
//     notifyListeners();
//   }
//
//   // تسجيل الدخول
//   Future<void> login(String username) async {
//     if (username.isEmpty) {
//       throw Exception('اسم المستخدم لا يمكن أن يكون فارغاً');
//     }
//     _isLoggedIn = true;
//     _username = username;
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_isLoggedInKey, true);
//     await prefs.setString(_usernameKey, username);
//
//     notifyListeners();
//   }
//
//   // تسجيل الخروج
//   Future<void> logout({bool clearFavorites = false}) async {
//     _isLoggedIn = false;
//     _username = null;
//
//     if (clearFavorites) {
//       _favorites.clear();
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.remove(_favoritesKey);
//     }
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_isLoggedInKey, false);
//     await prefs.remove(_usernameKey);
//
//     notifyListeners();
//   }
//
//   // تبديل الوضع الليلي
//   Future<void> toggleDarkMode() async {
//     _isDarkMode = !_isDarkMode;
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_darkModeKey, _isDarkMode);
//
//     notifyListeners();
//   }
//
//   // المفضلة
//   Future<void> addToFavorites(String itemId) async {
//     if (!_favorites.contains(itemId)) {
//       _favorites.add(itemId);
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setStringList(_favoritesKey, _favorites);
//
//       notifyListeners();
//     }
//   }
//
//   Future<void> removeFromFavorites(String itemId) async {
//     if (_favorites.contains(itemId)) {
//       _favorites.remove(itemId);
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setStringList(_favoritesKey, _favorites);
//
//       notifyListeners();
//     }
//   }
//
//   bool isFavorite(String itemId) {
//     return _favorites.contains(itemId);
//   }
//
//   // تحديث تقدم قراءة القرآن
//   Future<void> updateQuranProgress(int progress) async {
//     _quranProgress = progress.clamp(0, 100);
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(_quranProgressKey, _quranProgress);
//
//     notifyListeners();
//   }
//
//   // تحديث السورة الحالية
//   Future<void> updateCurrentSurah(int surahNumber) async {
//     if (surahNumber < 1) return;
//     _currentSurah = surahNumber;
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(_currentSurahKey, _currentSurah);
//
//     notifyListeners();
//   }
//
//   // تفعيل/تعطيل تذكيرات الصلاة
//   Future<void> togglePrayerReminders() async {
//     _prayerRemindersEnabled = !_prayerRemindersEnabled;
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_prayerRemindersKey, _prayerRemindersEnabled);
//
//     notifyListeners();
//   }
//
//   // تحديث أوقات الصلاة (مثلاً من API أو إعدادات المستخدم)
//   Future<void> updatePrayerTimes(Map<String, String> newTimes) async {
//     _prayerTimes = Map.from(newTimes);
//
//     final prefs = await SharedPreferences.getInstance();
//     // حفظ كـ query string (مثلاً: Fajr=05:00&Dhuhr=12:30...)
//     final encoded = Uri(queryParameters: _prayerTimes).query;
//     await prefs.setString(_prayerTimesKey, encoded);
//
//     notifyListeners();
//   }
// }
