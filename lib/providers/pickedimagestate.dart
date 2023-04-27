import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PickImageStae extends ChangeNotifier {
  String? _imagePath;
  String? get imagePath => _imagePath;
  Uint8List? _pickedFile;

  Uint8List? get pickedFile => _pickedFile;

  set imagePath(String? path) {
    _imagePath = path;
    notifyListeners();
  }

  set pickedFile(Uint8List? file) {
    _pickedFile = file;
    notifyListeners();
  }
}
