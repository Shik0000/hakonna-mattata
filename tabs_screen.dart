import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/Categories_screen.dart';
import 'package:flutter_application_1/modules/favoritescreen.dart';
import 'package:flutter_application_1/widgets/main_drawer.dart';

class TapScreen extends StatefulWidget {
  const TapScreen({Key key}) : super(key: key);

  @override
  State<TapScreen> createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': CategoriesScreen(),
      'title': 'categories',
    },
    {
      'page': FavoriteScreen(),
      'title': 'yourfavorites',
    },
  ];
  int _selectedPageIndex = 0;
  void _selectpage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal"),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectpage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: ("category")),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ("Favorites")),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
