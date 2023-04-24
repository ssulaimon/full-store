import 'package:flutter/cupertino.dart';

class DropDownItems extends ChangeNotifier {
  List<String> items = [
    'Vegetable',
    'Fruit Juice',
    'Soda',
    'Snacks',
    'Rice',
    'Desserts',
  ];
  String? _selectedValue;

  String? get selectedValue => _selectedValue;

  set selectedValue(String? value) {
    _selectedValue = value;
    notifyListeners();
  }
}
