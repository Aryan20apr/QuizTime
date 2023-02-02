import 'QuestionAlbum.dart';

class QuestionUpdateAlbum {
  QuestionData? _data;
  String? _httpStatus;
  bool? _success;

  QuestionUpdateAlbum({QuestionData? data, String? httpStatus, bool? success}) {
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

  QuestionData? get data => _data;
  set data(QuestionData? data) => _data = data;
  String? get httpStatus => _httpStatus;
  set httpStatus(String? httpStatus) => _httpStatus = httpStatus;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  QuestionUpdateAlbum.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new QuestionData.fromJson(json['data']) : null;
    _httpStatus = json['httpStatus'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['httpStatus'] = this._httpStatus;
    data['success'] = this._success;
    return data;
  }
}

