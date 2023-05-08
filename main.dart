import 'package:flutter/material.dart';
import 'package:flutter_application_1/dummy_data.dart';
import 'package:flutter_application_1/models/meal.dart';
import 'package:flutter_application_1/modules/Categories_screen.dart';
import 'package:flutter_application_1/modules/categorymealsscreen.dart';
import 'package:flutter_application_1/modules/filters_screen.dart';
import 'package:flutter_application_1/modules/meal_detail_screen.dart';
import 'package:flutter_application_1/modules/tabs_screen.dart';
import 'package:flutter_application_1/modules/welcomescreen.dart';

import 'modules/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactos': false,
    'vegan': false,
    'vegeterian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String, bool> _filterdata) {
    setState(() {
      _filters = _filterdata;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && meal.isGlutenFree) {
          return false;
        }

        if (_filters['lactos'] && meal.isLactoseFree) {
          return false;
        }

        if (_filters['vegan'] && meal.isVegan) {
          return false;
        }

        if (_filters['vegeterian'] && meal.isVegeterian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                subtitle1: TextStyle(
                    fontSize: 24,
                    fontFamily: "RobotoCondensed",
                    fontWeight: FontWeight.bold),
              )),
      //home: CategoriesScreen(),
      routes: {
        '/': (ctx) => WelcomeScreen(),
        categorymealscreen.routeName: (context) =>
            categorymealscreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FilterScreens.routeName: (context) =>
            FilterScreens(_filters, _setFilters),
      },
    );
  }
}
