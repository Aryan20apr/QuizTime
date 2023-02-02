import 'CategoryAlbum.dart';
import 'QuizAlbum.dart';

class StudentHistoryAlbum {
  List<HistoryStudent>? _data;
  String? _message;
  bool? _success;

  StudentHistoryAlbum({List<HistoryStudent>? data, String? message, bool? success}) {
    if (data != null) {
      this._data = data;
    }
    if (message != null) {
      this._message = message;
    }
    if (success != null) {
      this._success = success;
    }
  }

  List<HistoryStudent>? get data => _data;
  set data(List<HistoryStudent>? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  StudentHistoryAlbum.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <HistoryStudent>[];
      json['data'].forEach((v) {
        _data!.add(new HistoryStudent.fromJson(v));
      });
    }
    _message = json['message'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this._message;
    data['success'] = this._success;
    return data;
  }
}

class HistoryStudent {
  QuizData? _quiz;
  double? _marks;
  int? _attempted;
  int? _correct;
  int? _rating;
  String? _timestamp;

  HistoryStudent(
      {QuizData? quiz,
        double? marks,
        int? attempted,
        int? correct,
        int? rating,
        String? timestamp}) {
    if (quiz != null) {
      this._quiz = quiz;
    }
    if (marks != null) {
      this._marks = marks;
    }
    if (attempted != null) {
      this._attempted = attempted;
    }
    if (correct != null) {
      this._correct = correct;
    }
    if (rating != null) {
      this._rating = rating;
    }
    if (timestamp != null) {
      this._timestamp = timestamp;
    }
  }

  QuizData? get quiz => _quiz;
  set quiz(QuizData? quiz) => _quiz = quiz;
  double? get marks => _marks;
  set marks(double? marks) => _marks = marks;
  int? get attempted => _attempted;
  set attempted(int? attempted) => _attempted = attempted;
  int? get correct => _correct;
  set correct(int? correct) => _correct = correct;
  int? get rating => _rating;
  set rating(int? rating) => _rating = rating;
  String? get timestamp => _timestamp;
  set timestamp(String? timestamp) => _timestamp = timestamp;

  HistoryStudent.fromJson(Map<String, dynamic> json) {
    _quiz = json['quiz'] != null ? new QuizData.fromJson(json['quiz']) : null;
    _marks = json['marks'];
    _attempted = json['attempted'];
    _correct = json['correct'];
    _rating = json['rating'];
    _timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._quiz != null) {
      data['quiz'] = this._quiz!.toJson();
    }
    data['marks'] = this._marks;
    data['attempted'] = this._attempted;
    data['correct'] = this._correct;
    data['rating'] = this._rating;
    data['timestamp'] = this._timestamp;
    return data;
  }
}

