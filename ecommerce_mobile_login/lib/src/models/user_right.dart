import 'package:mobile_app_platform_widgets/common_exports.dart';

class UserRight {
  final int id;
  final int right;
  final int userData;
  final String module;
  final int? objectId;

  UserRight({
    this.objectId,
    required this.id,
    required this.module,
    required this.right,
    required this.userData,
  });

  factory UserRight.fromJson(Map<String, dynamic> json) {
    return UserRight(
      module: json['modul'].toString(),
      id: json['id'].toString().toInt(),
      right: json['right'].toString().toInt(),
      userData: json['UserData'].toString().toInt(),
      objectId: json['objectID']?.toString().toInt(),
    );
  }
  static List<UserRight> toList(List<Map<String, dynamic>> userRights) =>
      userRights.map((e) => UserRight.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'modul': module,
        'right': right,
        'objectID': objectId,
        'UserData': userData,
      };
}
