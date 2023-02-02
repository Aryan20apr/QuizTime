class UserAlbum {
  UserData? _data;
  String? _token;
  bool? _success;

  UserAlbum({UserData? data, String? token, bool? success}) {
    if (data != null) {
      this._data = data;
    }
    if (token != null) {
      this._token = token;
    }
    if (success != null) {
      this._success = success;
    }
  }

  UserData? get data => _data;
  set data(UserData? data) => _data = data;
  String? get token => _token;
  set token(String? token) => _token = token;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  UserAlbum.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
    _token = json['token'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['token'] = this._token;
    data['success'] = this._success;
    return data;
  }
}

class UserData {
  int? _id;
  String? _nickname;
  String? _password;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  bool? _enabled;
  String? _profileImage;
  List<UserRoles>? _userRoles;

  UserData(
      {int? id,
        String? nickname,
        String? password,
        String? firstName,
        String? lastName,
        String? email,
        String? phone,
        bool? enabled,
        String? profileImage,
        List<UserRoles>? userRoles}) {
    if (id != null) {
      this._id = id;
    }
    if (nickname != null) {
      this._nickname = nickname;
    }
    if (password != null) {
      this._password = password;
    }
    if (firstName != null) {
      this._firstName = firstName;
    }
    if (lastName != null) {
      this._lastName = lastName;
    }
    if (email != null) {
      this._email = email;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (enabled != null) {
      this._enabled = enabled;
    }
    if (profileImage != null) {
      this._profileImage = profileImage;
    }
    if (userRoles != null) {
      this._userRoles = userRoles;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get nickname => _nickname;
  set nickname(String? nickname) => _nickname = nickname;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get firstName => _firstName;
  set firstName(String? firstName) => _firstName = firstName;
  String? get lastName => _lastName;
  set lastName(String? lastName) => _lastName = lastName;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  bool? get enabled => _enabled;
  set enabled(bool? enabled) => _enabled = enabled;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  List<UserRoles>? get userRoles => _userRoles;
  set userRoles(List<UserRoles>? userRoles) => _userRoles = userRoles;

  UserData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nickname = json['nickname'];
    _password = json['password'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _phone = json['phone'];
    _enabled = json['enabled'];
    _profileImage = json['profileImage'];
    if (json['userRoles'] != null) {
      _userRoles = <UserRoles>[];
      json['userRoles'].forEach((v) {
        _userRoles!.add(new UserRoles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nickname'] = this._nickname;
    data['password'] = this._password;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['email'] = this._email;
    data['phone'] = this._phone;
    data['enabled'] = this._enabled;
    data['profileImage'] = this._profileImage;
    if (this._userRoles != null) {
      data['userRoles'] = this._userRoles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserRoles {
  int? _userRoleId;
  Role? _role;

  UserRoles({int? userRoleId, Role? role}) {
    if (userRoleId != null) {
      this._userRoleId = userRoleId;
    }
    if (role != null) {
      this._role = role;
    }
  }

  int? get userRoleId => _userRoleId;
  set userRoleId(int? userRoleId) => _userRoleId = userRoleId;
  Role? get role => _role;
  set role(Role? role) => _role = role;

  UserRoles.fromJson(Map<String, dynamic> json) {
    _userRoleId = json['userRoleId'];
    _role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userRoleId'] = this._userRoleId;
    if (this._role != null) {
      data['role'] = this._role!.toJson();
    }
    return data;
  }
}

class Role {
  int? _roleId;
  String? _roleName;

  Role({int? roleId, String? roleName}) {
    if (roleId != null) {
      this._roleId = roleId;
    }
    if (roleName != null) {
      this._roleName = roleName;
    }
  }

  int? get roleId => _roleId;
  set roleId(int? roleId) => _roleId = roleId;
  String? get roleName => _roleName;
  set roleName(String? roleName) => _roleName = roleName;

  Role.fromJson(Map<String, dynamic> json) {
    _roleId = json['roleId'];
    _roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleId'] = this._roleId;
    data['roleName'] = this._roleName;
    return data;
  }
}