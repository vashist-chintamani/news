import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tyrios_mobile_app_flutter_extensions/tyrios_mobile_app_flutter_extensions.dart';

extension StringExtensions on String {
  Uri toUri() => Uri.parse(this);

  int toInt() => int.parse(this);

  num toNum() => num.parse(this);

  double toDouble() => double.parse(this);

  String decodeToUtf8() => utf8.decode(codeUnits);

  String toURIEncodeComponent() => Uri.encodeComponent(this);

  String get removeWhiteSpace => split(" ").join("");

  String get shuffle => (split('')..shuffle()).join('');

  String get replaceWithUnderscore => replaceRange(
      1, length - 1, List.generate(length - 2, (index) => "-").toList().join());

  /// validation string extensions
  String? get emailValidate =>
      contains("@") ? null : "Please enter a valid email.";

  dynamic toJsonDecode() => jsonDecode(this);

  String removeAllHtmlTags() {
    final RegExp exp = RegExp("<[^>]*>", multiLine: true, caseSensitive: true);
    return replaceAll(exp, '');
  }

  String get toCamelCase {
    final separatedWords = split(RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%\s_]+'));
    final StringBuffer camelCaseStringBuffer = StringBuffer();
    for (final word in separatedWords) {
      camelCaseStringBuffer
          .write(word[0].toUpperCase() + word.substring(1).toLowerCase());
    }
    return camelCaseStringBuffer.toString()[0].toLowerCase() +
        camelCaseStringBuffer.toString().substring(1);
  }

  DateTime get toDateYMDHMS => DateTime.parse(this);

  bool get isValidEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);

  bool get isValidPhone => RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(this);

  bool get isValidPhoneLength => RegExp(r'^[0-9]+$').hasMatch(this);

  bool get isValidPassword => RegExp(
          r'^(?=(.*[a-z]){3,})(?=(.*[A-Z]){1,})(?=(.*[0-9]){2,})(?=(.*[!@#$%^&*()-__+.]){1,}).{8,}$')
      .hasMatch(this);

  bool get isValidPhoneOrEmail => RegExp(
          r'^((\+|\d{1,3})[\-\.\s]?)?(\(?\d{1,4}\)?[\-\.\s]?)?[\d\-.\s]{6,}$|^[\w._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      .hasMatch(this);

  Map<String, dynamic> castToJsonDecodeToMapOfStringDynamic() =>
      (jsonDecode(toString()) as Map).castToMapOfStringDynamic();

  List<Map<String, dynamic>> castToJsonDecodeToListOfMapOfStringDynamic() =>
      (jsonDecode(toString()) as List<dynamic>)
          .castToListOfMapOfStringDynamic();

  dynamic castToJsonDecode() => jsonDecode(this);

  Future<String> get loadFromRootBundle async =>
      await rootBundle.loadString(this);

  String get getOnlyDigits => replaceAll(RegExp(r'\D'), '');

  String get toSnakeCase => isEmpty
      ? ''
      : replaceAllMapped(
          RegExp('[A-Z]'), (Match match) => '_${match[0]!.toLowerCase()}');

  String get toSpaceCase {
    if (isEmpty) {
      return '';
    }

    return replaceAllMapped(
        RegExp('[A-Z]'), (Match match) => ' ${match[0]!.toLowerCase()}');
  }

  bool get isValidDate {
    try {
      DateTime.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }
}
