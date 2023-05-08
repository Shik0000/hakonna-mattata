import 'package:flutter/material.dart';

import 'package:flutter_application_1/widgets/main_drawer.dart';

class FilterScreens extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FilterScreens(this.currentFilters, this.saveFilters);

  @override
  State<FilterScreens> createState() => _FilterScreensState();
}

class _FilterScreensState extends State<FilterScreens> {
  bool isGlutenFree = false;
  bool isLactoseFree = false;
  bool isVegan = false;
  bool isVegeterian = false;
  @override
  void initState() {
    isGlutenFree = widget.currentFilters['gluten'];
    isLactoseFree = widget.currentFilters['lactos'];
    isVegan = widget.currentFilters['vegan'];
    isVegeterian = widget.currentFilters['vegeterian'];
    super.initState();
  }

  Widget buildListTile(String title, String description, bool currentValue,
      Function updatevalue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updatevalue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your filters"),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': isGlutenFree,
                'lactos': isLactoseFree,
                'vegan': isVegan,
                'vegeterian': isVegeterian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildListTile(
                  'Gluten free', 'only include gluten.free', isGlutenFree,
                  (newvalue) {
                setState(() {
                  isGlutenFree = newvalue;
                });
              }),
              buildListTile(
                  'LactoseFree', 'only include isLactoseFree', isLactoseFree,
                  (newvalue) {
                setState(() {
                  isLactoseFree = newvalue;
                });
              }),
              buildListTile('Vegan', 'only include Vegan.free', isVegan,
                  (newvalue) {
                setState(() {
                  isVegan = newvalue;
                });
              }),
              buildListTile(
                  'Vegeterian', 'only include Vegeterian.free', isVegeterian,
                  (newvalue) {
                setState(() {
                  isVegeterian = newvalue;
                });
              }),
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
