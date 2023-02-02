class UpdateQuizAlbum {
  int? _qid;
  String? _title;
  String? _description;
  String? _maxMarks;
  int? _numberOfQuestions;
  bool? _active;
  UpdateQuizCategory? _category;
  UpdateQuizUser? _user;

  UpdateQuizAlbum(
      {int? qid,
        String? title,
        String? description,
        String? maxMarks,
        int? numberOfQuestions,
        bool? active,
        UpdateQuizCategory? category,
        UpdateQuizUser? user}) {
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
    if (user != null) {
      this._user = user;
    }
  }

  int? get qid => _qid;
  set qid(int? qid) => _qid = qid;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get maxMarks => _maxMarks;
  set maxMarks(String? maxMarks) => _maxMarks = maxMarks;
  int? get numberOfQuestions => _numberOfQuestions;
  set numberOfQuestions(int? numberOfQuestions) =>
      _numberOfQuestions = numberOfQuestions;
  bool? get active => _active;
  set active(bool? active) => _active = active;
  UpdateQuizCategory? get category => _category;
  set category(UpdateQuizCategory? category) => _category = category;
  UpdateQuizUser? get user => _user;
  set user(UpdateQuizUser? user) => _user = user;

  UpdateQuizAlbum.fromJson(Map<String, dynamic> json) {
    _qid = json['qid'];
    _title = json['title'];
    _description = json['description'];
    _maxMarks = json['maxMarks'];
    _numberOfQuestions = json['numberOfQuestions'];
    _active = json['active'];
    _category = json['category'] != null
        ? new UpdateQuizCategory.fromJson(json['category'])
        : null;
    _user = json['user'] != null ? new UpdateQuizUser.fromJson(json['user']) : null;
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
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    return data;
  }
}

class UpdateQuizCategory {
  int? _cid;

  UpdateQuizCategory({int? cid}) {
    if (cid != null) {
      this._cid = cid;
    }
  }

  int? get cid => _cid;
  set cid(int? cid) => _cid = cid;

  UpdateQuizCategory.fromJson(Map<String, dynamic> json) {
    _cid = json['cid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this._cid;
    return data;
  }
}

class UpdateQuizUser {
  int? _id;

  UpdateQuizUser({int? id}) {
    if (id != null) {
      this._id = id;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;

  UpdateQuizUser.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    return data;
  }
}