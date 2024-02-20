import 'dart:convert';

extension MapParsing<T> on Map<T, T> {
  String castToJsonEncode() => jsonEncode(this);

  Map<String, dynamic> castToMapOfStringDynamic() => cast<String, dynamic>();

  Map<String, int> castToMapOfStringInt() => cast<String, int>();

  void renameKey(T previousName, T newName) {
    final T previousData = this[previousName] as T;
    this[newName] = previousData;
    remove(previousName);
  }
}
