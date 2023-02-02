import 'package:flutter/cupertino.dart';

class QuizActiveProvider extends ChangeNotifier
{
   bool isActive=false;

  void changeIsActive()
  {
    isActive=!isActive;
    notifyListeners();
  }
}