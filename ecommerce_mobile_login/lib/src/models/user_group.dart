import 'package:mobile_app_platform_widgets/common_exports.dart';

class UserGroup {
  final int id;
  final String name;
  final int nodeLeft;
  final String? image;
  final int nodeRight;
  final int nodeLevel;
  final String? userData;
  final String? groupRight;
  final String? description;
  final String? newsLetterMailData;

  UserGroup({
    this.image,
    this.userData,
    this.groupRight,
    this.description,
    required this.id,
    required this.name,
    required this.nodeLeft,
    required this.nodeRight,
    required this.nodeLevel,
    this.newsLetterMailData,
  });

  factory UserGroup.fromJson(Map<String, dynamic> json) {
    return UserGroup(
      name: json['name'].toString(),
      image: json['image']?.toString(),
      id: json['id'].toString().toInt(),
      userData: json['UserData']?.toString(),
      groupRight: json['GroupRight']?.toString(),
      description: json['description']?.toString(),
      nodeLeft: json['nodeLeft'].toString().toInt(),
      nodeLevel: json['nodeLevel'].toString().toInt(),
      nodeRight: json['nodeRight'].toString().toInt(),
      newsLetterMailData: json['NewsletterMailData']?.toString(),
    );
  }

  static List<UserGroup> toList(List<Map<String, dynamic>> userGroup) =>
      userGroup.map((e) => UserGroup.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'UserData': userData,
        'nodeLeft': nodeLeft,
        'nodeLevel': nodeLevel,
        'nodeRight': nodeRight,
        'GroupRight': groupRight,
        'description': description,
        'NewsletterMailData': newsLetterMailData,
      };
}
