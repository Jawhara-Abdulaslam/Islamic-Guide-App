import 'package:flutter/material.dart';
import '../model/model.dart';

class FavoritesScreen extends StatelessWidget {
  final List<dynamic> favoriteItems;
  final String appTitle;

  const FavoritesScreen({
    super.key,
    required this.favoriteItems,
    this.appTitle = 'المفضلة',
  });

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
          title: Text(
            appTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: favoriteItems.isEmpty
            ? _buildEmptyState()
            : _buildFavoritesList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          const Text(
            'لا توجد عناصر في المفضلة',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'اضغط على ♥ لإضافة أذكار للمفضلة',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        final item = favoriteItems[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildItemContent(item),
          ),
        );
      },
    );
  }

  Widget _buildItemContent(dynamic item) {
    if (item is zkar_after_pray) {
      return Column(
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
          const SizedBox(height: 12),
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
      );
    } else if (item is wird_night_morning) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            item.text,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 12),
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
      );
    } else {
      return Text(
        item.toString(),
        textAlign: TextAlign.right,
      );
    }
  }
}