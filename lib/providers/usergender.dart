import 'package:flutter/cupertino.dart';

class UserGender extends ChangeNotifier {
  List<String> genders = ['Male', 'Female'];

  String? _userGender;

  String? get userGender => _userGender;

  set userGender(String? gender) {
    _userGender = gender;
    notifyListeners();
  }
}
