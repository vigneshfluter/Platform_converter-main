import 'package:flutter/cupertino.dart';

class PlatformProvider extends ChangeNotifier {
  bool isIos = false;

  void changePlatform() {
    isIos = !isIos;
    notifyListeners();
  }
}
