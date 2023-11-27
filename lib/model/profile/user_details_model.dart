

class UserDetailsModel {
    bool? status;
    String? message;
    User? data;

    UserDetailsModel({
        this.status,
        this.message,
        this.data,
    });

    factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : User.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class User {
    String? userStatus;
    String? firstname;
    String? lastname;
    String? email;
    dynamic mobile;
    String? username;
    String? state;
    String? ucity;
    String? address1;
    String? uzip;
    String? isVendor;
    String? profileImage;

    User({
        this.userStatus,
        this.firstname,
        this.lastname,
        this.email,
        this.mobile,
        this.username,
        this.state,
        this.ucity,
        this.address1,
        this.uzip,
        this.isVendor,
        this.profileImage,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userStatus: json["user_status"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        mobile: json["mobile"],
        username: json["username"],
        state: json["state"],
        ucity: json["ucity"],
        address1: json["address1"],
        uzip: json["uzip"],
        isVendor: json["is_vendor"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "user_status": userStatus,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "mobile": mobile,
        "username": username,
        "state": state,
        "ucity": ucity,
        "address1": address1,
        "uzip": uzip,
        "is_vendor": isVendor,
        "profile_image": profileImage,
    };
}

