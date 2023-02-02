import 'CategoryAlbum.dart';

class QuizAlbum {
  List<QuizData>? _data;
  String? _httpStatus;
  bool? _success;

  QuizAlbum({List<QuizData>? data, String? httpStatus, bool? success}) {
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

  List<QuizData>? get data => _data;
  set data(List<QuizData>? data) => _data = data;
  String? get httpStatus => _httpStatus;
  set httpStatus(String? httpStatus) => _httpStatus = httpStatus;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  QuizAlbum.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <QuizData>[];
      json['data'].forEach((v) {
        _data!.add(new QuizData.fromJson(v));
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

class QuizData {
  int? _qid;
  String? _title;
  String? _description;
  int? _maxMarks;
  int? _numberOfQuestions;
  bool? _active;
  CategoryData? _category;
  String? _quizDuration;

  QuizData(
      {int? qid,
        String? title,
        String? description,
        int? maxMarks,
        int? numberOfQuestions,
        bool? active,
        CategoryData? category,
        String? quizDuration}) {
    if (qid != null) {
      this._qid = qid;
    }
    if (title != null) {
      this._title = title;
    }
    if (description != null) {
      this._description = description;
    }
    if (maxMarks != null) {
      this._maxMarks = maxMarks;
    }
    if (numberOfQuestions != null) {
      this._numberOfQuestions = numberOfQuestions;
    }
    if (active != null) {
      this._active = active;
    }
    if (category != null) {
      this._category = category;
    }
    if (quizDuration != null) {
      this._quizDuration = quizDuration;
    }
  }

  int? get qid => _qid;
  set qid(int? qid) => _qid = qid;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  int? get maxMarks => _maxMarks;
  set maxMarks(int? maxMarks) => _maxMarks = maxMarks;
  int? get numberOfQuestions => _numberOfQuestions;
  set numberOfQuestions(int? numberOfQuestions) =>
      _numberOfQuestions = numberOfQuestions;
  bool? get active => _active;
  set active(bool? active) => _active = active;
  CategoryData? get category => _category;
  set category(CategoryData? category) => _category = category;
  String? get quizDuration => _quizDuration;
  set quizDuration(String? quizDuration) => _quizDuration = quizDuration;

  QuizData.fromJson(Map<String, dynamic> json) {
    _qid = json['qid'];
    _title = json['title'];
    _description = json['description'];
    _maxMarks = json['maxMarks'];
    _numberOfQuestions = json['numberOfQuestions'];
    _active = json['active'];
    _category = json['category'] != null
        ? new CategoryData.fromJson(json['category'])
        : null;
    _quizDuration = json['quizDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qid'] = this._qid;
    data['title'] = this._title;
    data['description'] = this._description;
    data['maxMarks'] = this._maxMarks;
    data['numberOfQuestions'] = this._numberOfQuestions;
    data['active'] = this._active;
    if (this._category != null) {
      data['category'] = this._category!.toJson();
    }
    data['quizDuration'] = this._quizDuration;
    return data;
  }
}

