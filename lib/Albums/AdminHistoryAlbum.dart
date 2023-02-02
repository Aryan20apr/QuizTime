class AdminHistoryAlbum {
  List<AdminHistoryData>? _data;
  String? _message;
  bool? _success;

  AdminHistoryAlbum({List<AdminHistoryData>? data, String? message, bool? success}) {
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

  List<AdminHistoryData>? get data => _data;
  set data(List<AdminHistoryData>? data) => _data = data;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  AdminHistoryAlbum.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <AdminHistoryData>[];
      json['data'].forEach((v) {
        _data!.add(new AdminHistoryData.fromJson(v));
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

class AdminHistoryData {
  UserQuizDTO? _user;
  double? _marks;
  int? _attempted;
  int? _correct;
  int? _rating;
  String? _timestamp;

  AdminHistoryData(
      {UserQuizDTO? user,
        double? marks,
        int? attempted,
        int? correct,
        int? rating,
        String? timestamp}) {
    if (user != null) {
      this._user = user;
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

  UserQuizDTO? get user => _user;
  set user(UserQuizDTO? user) => _user = user;
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

  AdminHistoryData.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null ? new UserQuizDTO.fromJson(json['user']) : null;
    _marks = json['marks'];
    _attempted = json['attempted'];
    _correct = json['correct'];
    _rating = json['rating'];
    _timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    data['marks'] = this._marks;
    data['attempted'] = this._attempted;
    data['correct'] = this._correct;
    data['rating'] = this._rating;
    data['timestamp'] = this._timestamp;
    return data;
  }
}

class UserQuizDTO {
  int? _id;
  String? _nickname;
  String? _firstName;
  String? _lastName;

  UserQuizDTO({int? id, String? nickname, String? firstName, String? lastName}) {
    if (id != null) {
      this._id = id;
    }
    if (nickname != null) {
      this._nickname = nickname;
    }
    if (firstName != null) {
      this._firstName = firstName;
    }
    if (lastName != null) {
      this._lastName = lastName;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get nickname => _nickname;
  set nickname(String? nickname) => _nickname = nickname;
  String? get firstName => _firstName;
  set firstName(String? firstName) => _firstName = firstName;
  String? get lastName => _lastName;
  set lastName(String? lastName) => _lastName = lastName;

  UserQuizDTO.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nickname = json['nickname'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nickname'] = this._nickname;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    return data;
  }
}