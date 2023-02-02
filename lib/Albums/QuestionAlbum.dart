class QuestionAlbum {
  List<QuestionData>? _data;
  String? _httpStatus;
  bool? _success;

  QuestionAlbum({List<QuestionData>? data, String? httpStatus, bool? success}) {
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

  List<QuestionData>? get data => _data;
  set data(List<QuestionData>? data) => _data = data;
  String? get httpStatus => _httpStatus;
  set httpStatus(String? httpStatus) => _httpStatus = httpStatus;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  QuestionAlbum.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <QuestionData>[];
      json['data'].forEach((v) {
        _data!.add(new QuestionData.fromJson(v));
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

class QuestionData {
  String? _content;
  String? _image;
  String? _option1;
  String? _option2;
  String? _option3;
  String? _option4;
  String? _answer;
  String? _givenAnswer;
  int? _qid;

  QuestionData(
      {String? content,
        String? image,
        String? option1,
        String? option2,
        String? option3,
        String? option4,
        String? answer,
        Null? givenAnswer,
        int? qid}) {
    if (content != null) {
      this._content = content;
    }
    if (image != null) {
      this._image = image;
    }
    if (option1 != null) {
      this._option1 = option1;
    }
    if (option2 != null) {
      this._option2 = option2;
    }
    if (option3 != null) {
      this._option3 = option3;
    }
    if (option4 != null) {
      this._option4 = option4;
    }
    if (answer != null) {
      this._answer = answer;
    }
    if (givenAnswer != null) {
      this._givenAnswer = givenAnswer;
    }
    if (qid != null) {
      this._qid = qid;
    }
  }

  String? get content => _content;
  set content(String? content) => _content = content;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get option1 => _option1;
  set option1(String? option1) => _option1 = option1;
  String? get option2 => _option2;
  set option2(String? option2) => _option2 = option2;
  String? get option3 => _option3;
  set option3(String? option3) => _option3 = option3;
  String? get option4 => _option4;
  set option4(String? option4) => _option4 = option4;
  String? get answer => _answer;
  set answer(String? answer) => _answer = answer;
  String? get givenAnswer => _givenAnswer;
  set givenAnswer(String? givenAnswer) => _givenAnswer = givenAnswer;
  int? get qid => _qid;
  set qid(int? qid) => _qid = qid;

  QuestionData.fromJson(Map<String, dynamic> json) {
    _content = json['content'];
    _image = json['image'];
    _option1 = json['option1'];
    _option2 = json['option2'];
    _option3 = json['option3'];
    _option4 = json['option4'];
    _answer = json['answer'];
    _givenAnswer = json['givenAnswer'];
    _qid = json['qid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this._content;
    data['image'] = this._image;
    data['option1'] = this._option1;
    data['option2'] = this._option2;
    data['option3'] = this._option3;
    data['option4'] = this._option4;
    data['answer'] = this._answer;
    data['givenAnswer'] = this._givenAnswer;
    data['qid'] = this._qid;
    return data;
  }
}