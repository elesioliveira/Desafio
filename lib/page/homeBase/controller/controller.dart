import 'package:flutter/cupertino.dart';

class BaseScreenController with ChangeNotifier {
  int pageController = 0;

  mudarPage(int index) {
    pageController = index;
    notifyListeners();
  }
}
