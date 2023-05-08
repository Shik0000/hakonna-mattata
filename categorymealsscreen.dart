import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/meal.dart';
import 'package:flutter_application_1/widgets/meal_item.dart';
import '../dummy_data.dart';

class categorymealscreen extends StatefulWidget {
  static const routeName = 'category_meals';

  final List<Meal> availableMeals;
  categorymealscreen(this.availableMeals);

  @override
  State<categorymealscreen> createState() => _categorymealscreenState();
}

class _categorymealscreenState extends State<categorymealscreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  @override
  void didChangeDependencies() {
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final CategoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    displayMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(CategoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals[index].id,
            imageUrl: displayMeals[index].imageUrl,
            title: displayMeals[index].title,
            duration: displayMeals[index].duration,
            complexty: displayMeals[index].complexty,
            affordability: displayMeals[index].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}
