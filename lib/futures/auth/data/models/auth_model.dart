class AuthModel {
  String name;
  String userName;
  String updatedAt;
  String createdAt;
  int id;
  String token;
  int AYPSSID;
  String subjectTrack;

  AuthModel(
      {required this.name,
      required this.userName,
      required this.updatedAt,
      required this.createdAt,
      required this.id,
      required this.token,
      required this.AYPSSID,
      required this.subjectTrack});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      name: json["name"],
      userName: json["userName"],
      updatedAt: json["updated_at"],
      createdAt: json["created_at"],
      id: json["id"],
      token: json["token"],
      AYPSSID: json["AYPSS_id"] ?? -1,
      subjectTrack: json["subjectTrack"] ?? "");
}

/////////

class AuthParams {
  String? name;
  String userName;
  String password;
  String? deviceToken;

  AuthParams(
      {this.name,
      required this.userName,
      required this.password,
      this.deviceToken});

  Map<String, dynamic> toJsonLogin() => {
        "userName": userName,
        "password": password,
      };

  Map<String, dynamic> toJsonRegister() => {
        "name": name,
        "userName": userName,
        "password": password,
        "deviceToken": deviceToken
      };
}

class GoogleAuthParams {
  String accessToken;
  String deviceToken;

  GoogleAuthParams({required this.accessToken, required this.deviceToken});

  Map<String, dynamic> toJsonLogin() => {
        "deviceToken": deviceToken,
        "accessToken": accessToken,
      };
}
