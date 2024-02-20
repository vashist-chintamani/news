

import 'package:tyrios_news_app/utilities/common_exports.dart';

base class Blog {
  final int id;
  final int categoryId;
  final String title;
  final String? teaserText;
  final TYRIOSImage? teaserImage;
  final HtmlContent? content;
  final DateTime? updateTime;
  final DateTime? publicationTime;
  final int? readingTime;
  final Author? author;
  final String? link;
  bool favourite;
  WebViewController? webViewController;

  Blog({
    required this.categoryId,
    required this.id,
    required this.title,
    this.link,
    this.author,
    this.content,
    this.teaserText,
    this.updateTime,
    this.readingTime,
    this.teaserImage,
    this.publicationTime,
    this.webViewController,
    this.favourite = false,
  });

  set setFavourite(bool value) => favourite = value;

  set setWebViewContent(WebViewController controller) =>
      webViewController = controller;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        link: json['link'] as String?,
        title: json['title'].toString(),
        id: json['id'].toString().toInt(),
        readingTime: json['readingTime'] as int?,
        teaserText: json['teaserText'] as String?,
        categoryId: json['categoryId'].toString().toInt(),
        author: Author.fromJson(json['author'] as Map<String, dynamic>),
        teaserImage: json['teaserImage'] != null
            ? TYRIOSImage.fromJson(json['teaserImage'] as Map<String, dynamic>)
            : null,
        updateTime: json['updateTime'] != null
            ? DateTime.parse(json['updateTime'].toString())
            : null,
        publicationTime: json['publicationTime'] != null
            ? DateTime.parse(json['publicationTime'].toString())
            : null,
        content: json['content'] != null
            ? HtmlContent.fromJson(json['content'] as Map<String, dynamic>)
            : null,
      );

  Blog copyWith(Map<String, dynamic> json) => Blog(
        id: json['id']?.toString().toInt() ?? id,
        title: json['title']?.toString() ?? title,
        link: json['link'] as String? ?? link,
        readingTime: json['readingTime'] as int? ?? readingTime,
        teaserText: json['teaserText'] as String? ?? teaserText,
        categoryId: json['categoryId']?.toString().toInt() ?? categoryId,
        teaserImage: json['teaserImage'] != null
            ? TYRIOSImage.fromJson(json['teaserImage'] as Map<String, dynamic>)
            : teaserImage,
        author: json['author'] != null
            ? Author.fromJson(json['author'] as Map<String, dynamic>)
            : author,
        updateTime: json['updateTime'] != null
            ? DateTime.parse(json['updateTime'].toString())
            : updateTime,
        publicationTime: json['publicationTime'] != null
            ? DateTime.parse(json['publicationTime'].toString())
            : publicationTime,
        content: json['content'] != null
            ? HtmlContent.fromJson(json['content'] as Map<String, dynamic>)
            : content,
        favourite: favourite,
        webViewController: webViewController,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'link': link,
        'title': title,
        'author': author,
        'content': content,
        'updateTime': updateTime,
        'categoryId': categoryId,
        'teaserText': teaserText,
        'teaserImage': teaserImage,
        'readingTime': readingTime,
        'publicationTime': publicationTime,
        'webViewController': webViewController,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Blog && other.id == id);

  @override
  int get hashCode => id.hashCode;
}

base class BlogCategory extends Blog {
  BlogCategory({
    required super.id,
    required super.title,
    required super.categoryId,
  });

  factory BlogCategory.fromJson(Map<String, dynamic> e) => BlogCategory(
      id: e['id'].toString().toInt(),
      title: e['title'] as String,
      categoryId: e['id'].toString().toInt());
}

class HtmlContent {
  final String? title;
  final String html;
  final String? htmlHeader;

  HtmlContent(this.title, this.html, this.htmlHeader);

  factory HtmlContent.fromJson(Map<String, dynamic> json) => HtmlContent(
        json['title'] as String?,
        json['html'] as String,
        json['htmlHeader'] as String?,
      );

  Map<String, dynamic> toJson() =>
      {'title': title, 'html': html, 'htmlHeader': htmlHeader};
}

class Author {
  final String title;
  final String lastName;
  final String firstName;
  final String profileText;
  final TYRIOSImage? image;

  String get getFullName => '$firstName $lastName';

  Author({
    required this.title,
    required this.lastName,
    required this.firstName,
    required this.profileText,
    required this.image,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        title: json['title'] != null ? json['title'].toString() : '',
        lastName: json['lastName'] as String,
        firstName: json['firstName'] as String,
        profileText: json['profileText'] as String? ?? '',
        image: json['profileImage'] != null
            ? TYRIOSImage.fromJson(json['profileImage'] as Map<String, dynamic>)
            : null,
      );
}

class TYRIOSImage {
  final int id;
  final String type;
  final String hash;
  final double version;
  final int securityLevel;
  final String encodedFileName;

  TYRIOSImage({
    required this.id,
    required this.encodedFileName,
    required this.type,
    required this.hash,
    required this.securityLevel,
    required this.version,
  });

  factory TYRIOSImage.fromJson(Map<String, dynamic> json) => TYRIOSImage(
        id: json['id'] as int,
        type: json['type'] as String,
        hash: json['hash'] as String? ?? '',
        version: json['version'].toString().toDouble(),
        encodedFileName: json['encodedFileName'] as String,
        securityLevel: json['securityLevel'].toString().toInt(),
      );
}
