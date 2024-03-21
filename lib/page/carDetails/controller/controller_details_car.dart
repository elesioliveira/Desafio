import 'package:flutter/material.dart';

class DetailsController with ChangeNotifier {
  bool likeCar = false;

  curtirCarro() {
    likeCar = !likeCar;
    notifyListeners();
  }
}
