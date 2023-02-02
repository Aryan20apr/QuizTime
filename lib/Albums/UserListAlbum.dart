import 'UserAlbum.dart';

class UserListAlbum {
  List<UserData>? _data;
  String? _httpStatus;
  bool? _success;

  UserListAlbum({List<UserData>? data, String? httpStatus, bool? success}) {
    if (data != null) {
      this._data = data;
    }
    if (httpStatus != null) {
      this._httpStatus = httpStatus;
    }
    if (success != null) {
      this._success = success;
    }
  }

  List<UserData>? get data => _data;
  set data(List<UserData>? data) => _data = data;
  String? get httpStatus => _httpStatus;
  set httpStatus(String? httpStatus) => _httpStatus = httpStatus;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  UserListAlbum.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <UserData>[];
      json['data'].forEach((v) {
        _data!.add(new UserData.fromJson(v));
      });
    }
    _httpStatus = json['httpStatus'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    data['httpStatus'] = this._httpStatus;
    data['success'] = this._success;
    return data;
  }
}
