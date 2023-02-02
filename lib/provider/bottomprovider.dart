
import 'package:flutter/cupertino.dart';

class BottomProvider extends ChangeNotifier
{
  int currentTab=0;

  void changeTab(int t)
  {
    currentTab=t;
    notifyListeners();
  }
}