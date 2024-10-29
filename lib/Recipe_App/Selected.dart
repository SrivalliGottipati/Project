import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider.dart';
class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple,
          title: Text(
            "Favorite meals",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Consumer<changesProvider>(
            builder: (context, value, child) => ListView.separated(
                itemCount: value.favMeals.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(value.favMeals[index].imageUrl,
                              fit: BoxFit.cover),
                        )),
                    title: Text(value.favMeals[index].title),
                    trailing: IconButton(
                        onPressed: () {
                          value.addMeals(value.favMeals[index]);
                        },
                        icon: Icon(
                            value.MealStatus(value.favMeals[index])
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red)),
                  );
                })));
  }
}