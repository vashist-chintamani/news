import 'package:tyrios_news_app/utilities/common_exports.dart';

Future<void> setupTheme() async {
  await Hive.openBox<dynamic>('appTheme');

  if (await Hive.boxExists('appTheme')) {
    final String themeMode =
        Hive.box<dynamic>('appTheme').get('themeValue')?.toString() ??
            ThemeMode.system.name;
    appThemeMode.value =
        ThemeMode.values.singleWhere((element) => element.name == themeMode);
  } else {
    unawaited(
        Hive.box<dynamic>('appTheme').put('themeValue', ThemeMode.system.name));
  }
}