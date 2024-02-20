class LoginModel {
  final String key;
  final String lang;
  final String loginType;
  final dynamic userData;

  LoginModel({
    this.userData,
    required this.key,
    required this.lang,
    required this.loginType,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        key: json['key'].toString(),
        lang: json['lang'].toString(),
        userData: json['UserData'],
        loginType: json['loginType'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'lang': lang,
        'UserData': userData,
        'loginType': loginType,
      };
}
