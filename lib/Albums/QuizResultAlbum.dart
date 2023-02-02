class QuizResultAlbum {
  QuizResultData? _data;
  String? _message;
  bool? _success;

  QuizResultAlbum({QuizResultData? data, String? message, bool? success}) {
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

  QuizResultData? get data => _data;
  set data(QuizResultData? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  QuizResultAlbum.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new QuizResultData.fromJson(json['data']) : null;
    _message = json['message'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['message'] = this._message;
    data['success'] = this._success;
    return data;
  }
}

class QuizResultData {
  double? _marks;
  int? _attempted;
  int? _correct;
  int? _rating;
  Null? _timestamp;
  bool? _result;

  QuizResultData(
      {double? marks,
        int? attempted,
        int? correct,
        int? rating,
        Null? timestamp,
        bool? result}) {
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
    if (result != null) {
      this._result = result;
    }
  }

  double? get marks => _marks;
  set marks(double? marks) => _marks = marks;
  int? get attempted => _attempted;
  set attempted(int? attempted) => _attempted = attempted;
  int? get correct => _correct;
  set correct(int? correct) => _correct = correct;
  int? get rating => _rating;
  set rating(int? rating) => _rating = rating;
  Null? get timestamp => _timestamp;
  set timestamp(Null? timestamp) => _timestamp = timestamp;
  bool? get result => _result;
  set result(bool? result) => _result = result;

  QuizResultData.fromJson(Map<String, dynamic> json) {
    _marks = json['marks'];
    _attempted = json['attempted'];
    _correct = json['correct'];
    _rating = json['rating'];
    _timestamp = json['timestamp'];
    _result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marks'] = this._marks;
    data['attempted'] = this._attempted;
    data['correct'] = this._correct;
    data['rating'] = this._rating;
    data['timestamp'] = this._timestamp;
    data['result'] = this._result;
    return data;
  }
}