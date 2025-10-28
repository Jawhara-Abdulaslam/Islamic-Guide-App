import 'dart:convert';
import '../model/model.dart';
import 'package:flutter/material.dart';

class HisnulMuslimPage extends StatefulWidget {
  const HisnulMuslimPage({super.key});

  @override
  State<HisnulMuslimPage> createState() => _HisnulMuslimPageState();
}

class _HisnulMuslimPageState extends State<HisnulMuslimPage> {
  late Future<List<hisnulmuslim>> azkarFuture;

  @override
  void initState() {
    super.initState();

    azkarFuture = loadAzkar(context);
  }

  Future<List<hisnulmuslim>> loadAzkar(BuildContext context) async {
    final jsonStr = await DefaultAssetBundle.of(context).loadString('assets/db_json/hisnulmuslim.json');
    final List<dynamic> data = json.decode(jsonStr);
    return data.map((json) => hisnulmuslim.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(  // لجعل النص من اليمين إلى اليسار
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F1EB),
        appBar: AppBar(
          title: Align(
            alignment: Alignment.topCenter,
            child: Text('حصن المسلم'),
          ),
          backgroundColor: const Color(0xFF528777),
          elevation: 1,
          titleTextStyle: TextStyle(
            color: Colors.grey[900],
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          iconTheme: IconThemeData(color: Colors.grey[900]),
        ),
        body: FutureBuilder<List<hisnulmuslim>>(
          future: azkarFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("خطأ: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("لا توجد بيانات"));
            } else {
              final items = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
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
                          Text(

                            item.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey[900],
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item.arabic,
                            style: const TextStyle(
                              fontSize: 22,
                              height: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.english,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "المصدر: ${item.reference}",
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
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