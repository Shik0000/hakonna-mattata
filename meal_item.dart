import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/meal.dart';
import 'package:flutter_application_1/modules/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final int duration;
  final String title;
  final String imageUrl;
  final Complexty complexty;
  final Affordability affordability;
  final Function removeItem;
  const MealItem(
      {@required this.id,
      @required this.duration,
      @required this.title,
      @required this.imageUrl,
      @required this.complexty,
      @required this.affordability,
      @required this.removeItem});

  String get complextyText {
    switch (complexty) {
      case Complexty.Simple:
        return 'Simple';
        break;
      case Complexty.Challenging:
        return 'Challenging';
        break;
      case Complexty.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurius:
        return 'Hard';
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  void selectmeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(
          MealDetailScreen.routeName,
          arguments: id,
        )
        .then((result) => {if (result != null) removeItem(result)});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectmeal(context),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 300,
                      color: Colors.black54,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 26, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule),
                        SizedBox(width: 6),
                        Text("$duration min"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work),
                        SizedBox(width: 6),
                        Text("$complextyText"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money),
                        SizedBox(width: 6),
                        Text("$affordability "),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
