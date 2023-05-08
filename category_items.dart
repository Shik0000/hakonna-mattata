import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/categorymealsscreen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  CategoryItem(this.id, this.color, this.title);
  void selectcategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      categorymealscreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectcategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title, style: Theme.of(context).textTheme.subtitle1),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            color.withOpacity(0.6),
            color,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
