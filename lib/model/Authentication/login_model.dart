class LoginModel {
  bool? status;
  String? message;
  LoginData? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class LoginData {
  String? token;
  String? userStatus;
  String? id;
  String? refId;
  String? levelId;
  String? firstname;
  String? lastname;
  String? email;
  String? isVendor;
  String? profileAvatar;
  String? mobile;

  LoginData({
    this.token,
    this.userStatus,
    this.id,
    this.refId,
    this.levelId,
    this.firstname,
    this.lastname,
    this.email,
    this.isVendor,
    this.profileAvatar,
    this.mobile,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"],
        userStatus: json["user_status"],
        id: json["id"],
        refId: json["ref_id"],
        levelId: json["level_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        isVendor: json["is_vendor"],
        mobile: json["mobile"],
        profileAvatar: json["profile_avatar"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_status": userStatus,
        "id": id,
        "ref_id": refId,
        "level_id": levelId,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "is_vendor": isVendor,
        "profile_avatar": profileAvatar,
      };
}
