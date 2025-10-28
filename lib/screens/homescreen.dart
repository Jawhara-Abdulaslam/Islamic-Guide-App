import 'package:finalproject/model/app_state.dart';
import 'package:provider/provider.dart';

import '../controller/app_rout.dart';
import '../model/model.dart';
import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Future<void> _logout(BuildContext context) async {
//   await Supabase.instance.client.auth.signOut();
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(builder: (_) => const LoginPage()),
//   );
// }
Future<void> _logout(BuildContext context) async {
  // await Supabase.instance.client.auth.signOut();

  final appState = Provider.of<AppState>(context, listen: false);
  await appState.logout(clearFavorites: true);

  // Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(builder: (_) => const LoginPage()),
  // );
}



class _HomeScreenState extends State<HomeScreen> {
  final List<Item> _items = [
    Item(id: 1, name: 'القرآن الكريم', type: 'quran'),
    Item(id: 2, name: 'الأحاديث', type: 'hisnulmuslim'),
    Item(id: 3, name: 'أسماء الله الحسنى', type: 'allah_names'),
    Item(id: 4, name: 'أذكار الصباح والمساء', type: 'wird_night_morning'),
    Item(id: 5, name: 'أذكار بعد الصلاة', type: 'zkar_after_pray'),
  ];

  int _selectedIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      // الرئيسية
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.quran);
        break;
      // case 2:
      //   Navigator.pushNamed(context, AppRoutes.Favorite);
      //   break;
    }
  }

  void _onItemTapped(Item item) {
    switch (item.type) {
      case 'quran':
        Navigator.pushNamed(context, AppRoutes.quran);
        break;
      case 'hisnulmuslim':
        Navigator.pushNamed(context, AppRoutes.hadith);
        break;
      case 'allah_names':
        Navigator.pushNamed(context, AppRoutes.allahNames);
        break;
      case 'wird_night_morning':
        Navigator.pushNamed(context, AppRoutes.morningEvening);
        break;
      case 'zkar_after_pray':
        Navigator.pushNamed(context, AppRoutes.afterPrayer);
        break;
      // case 'Favorite':
      //   Navigator.pushNamed(context, AppRoutes.Favorite);
      //   break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final user = Supabase.instance.client.auth.currentUser;

    return Directionality(
        textDirection: TextDirection.rtl,
        child:  Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),
      appBar: AppBar(
        elevation: 1,
        title: Align(
          alignment: Alignment.topCenter,
          child: Text(
            'الرئيسية',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xFF528777),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),

        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () {
        //
        //     },
        //   ),
        // ],
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (ctx, index) {
            final item = _items[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                leading: Icon(
                  Icons.menu_book_rounded,
                  color: Colors.green[400],
                  size: 28,
                ),
                title: Text(
                  item.name,
                  style: TextStyle(
                    color: Colors.grey[850],
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                onTap: () => _onItemTapped(item),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTapped,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey[500],
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: 'القرآن',
          ),
        //   BottomNavigationBarItem(
        //     icon: Icon(Icons.favorite),
        //     label: 'المفضلة',
        //   ),
         ],
        //   ),
        ),
    ),
    );
  }
}