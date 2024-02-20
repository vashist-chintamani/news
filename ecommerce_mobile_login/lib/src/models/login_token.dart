class LoginToken {
  final String token;
  final String validUntil;
  final String refreshToken;
  final String refreshValidUntil;

  LoginToken({
    required this.token,
    required this.validUntil,
    required this.refreshToken,
    required this.refreshValidUntil,
  });

  factory LoginToken.fromJson(Map<String, dynamic> json) => LoginToken(
        token: json["token"].toString(),
        validUntil: json["validUntil"].toString(),
        refreshToken: json["refreshToken"].toString(),
        refreshValidUntil: json["refreshValidUntil"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "validUntil": validUntil,
        "refreshToken": refreshToken,
        "refreshValidUntil": refreshValidUntil,
      };
}
