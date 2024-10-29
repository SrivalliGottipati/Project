import 'package:flutter/material.dart';

import '../meals_model.dart';
class changesProvider extends ChangeNotifier{
  int _changeIndex = 0;
  int get changeIndex => _changeIndex;
  int _changeMealIndex = 0;
  int get changeMealIndex => _changeMealIndex;
  List<Meal> _favMeals = [];
  List<Meal> get favMeals => _favMeals;
  get index => null;
  void setIndex(int index){
    _changeIndex = index;
    notifyListeners();
  }
  void setMealIndex(int ind){
    _changeMealIndex = ind;
    notifyListeners();
  }
  addMeals(Meal meal) {
    if (_favMeals.contains(meal)) {
      _favMeals.remove(meal);
    } else {
      _favMeals.add(meal);
    }
    notifyListeners();
  }
  bool MealStatus(Meal color) => _favMeals.contains(color);
}