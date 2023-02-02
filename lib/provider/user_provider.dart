import 'package:flutter/cupertino.dart';

import '../util/Constants.dart';

class UserProvider extends ChangeNotifier {
  String _firstname = '';
  String _lastname = '';
  String _username = '';
  String _email = '';
  String _phoneNumber = '';
  int _id = 0;
  int _userRoleId = 0;
  String _roleName = '';
  int _roleId = 0;
  LoadingStatus _isloading=LoadingStatus.loading;
  String _token='';
  bool isInitialized=false;
  LoadingStatus get isloading => _isloading;

  set isloading(LoadingStatus value) {
    _isloading = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  bool _enabled=true;

  String get firstname => _firstname;

  set firstname(String value) {
    _firstname = value;
  }

  String get lastname => _lastname;

  set lastname(String valueString) {
    _lastname = valueString;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get userRoleId => _userRoleId;

  set userRoleId(int value) {
    _userRoleId = value;
  }

  String get roleName => _roleName;

  set roleName(String value) {
    _roleName = value;
  }

  int get roleId => _roleId;

  set roleId(int value) {
    _roleId = value;
  }

  void updateUser(String username,String firstName,String lastName )
  {
    _username=username;
    _firstname=firstName;
    _lastname=lastName;
    notifyListeners();
  }

  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
  }

  void updateLoadingStatus(LoadingStatus loadingStatus)
  {
    this.isloading=loadingStatus;
    notifyListeners();
  }
  void updateInitialization()
  {
    this.isInitialized=!this.isInitialized;
    notifyListeners();
  }
}

