import 'dart:convert';
import 'dart:developer';

extension AppObjectExtensions on Object? {
  void toLog() => log(toString());

  String toJsonEncode() => jsonEncode(this);
}
