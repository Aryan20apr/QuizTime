class CategoryAlbum {
  List<CategoryData>? _data;
  String? _httpStatus;
  bool? _success;

  CategoryAlbum({List<CategoryData>? data, String? httpStatus, bool? success}) {
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

  List<CategoryData>? get data => _data;
  set data(List<CategoryData>? data) => _data = data;
  String? get httpStatus => _httpStatus;
  set httpStatus(String? httpStatus) => _httpStatus = httpStatus;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  CategoryAlbum.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <CategoryData>[];
      json['data'].forEach((v) {
        _data!.add(new CategoryData.fromJson(v));
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

class CategoryData {
  int? _cid;
  String? _title;
  String? _description;

  CategoryData({int? cid, String? title, String? description}) {
    if (cid != null) {
      this._cid = cid;
    }
    if (title != null) {
      this._title = title;
    }
    if (description != null) {
      this._description = description;
    }
  }

  int? get cid => _cid;
  set cid(int? cid) => _cid = cid;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;

  CategoryData.fromJson(Map<String, dynamic> json) {
    _cid = json['cid'];
    _title = json['title'];
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this._cid;
    data['title'] = this._title;
    data['description'] = this._description;
    return data;
  }
}