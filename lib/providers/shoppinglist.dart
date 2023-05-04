import 'package:flutter/cupertino.dart';
import 'package:fullstore/models/itemmodel.dart';

class ShoppingList extends ChangeNotifier {
  List<ItemModel> item = [];

  void addItem({required ItemModel itemModel}) {
    item.add(itemModel);
    notifyListeners();
  }

  void delete({required int index}) {
    item.removeAt(index);
    notifyListeners();
  }
}

class ShoppingLenght extends ChangeNotifier {
  int _lenght = 0;
  int get lenght => _lenght;
  set lenght(int index) {
    _lenght = index;
    notifyListeners();
  }
}
