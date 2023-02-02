import 'package:flutter/material.dart';
class OptionProvider extends ChangeNotifier
{
  int _optionSelected=-1;
  void changeSelection(int option)
  {
    optionSelected=option;
    notifyListeners();
  }

  set optionSelected(int value) {
    _optionSelected = value;
  }

  int get optionSelected => _optionSelected;
}