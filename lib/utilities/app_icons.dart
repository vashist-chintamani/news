import 'dart:io';

import 'package:tyrios_news_app/utilities/common_exports.dart';

class AppIcons {
  // static const String logo = 'assets/icons/Logo.svg';
  static IconData bookmark =
      Platform.isIOS ? CupertinoIcons.bookmark : Icons.bookmark_outline;

  static IconData bookmarkFill =
      Platform.isIOS ? CupertinoIcons.bookmark_fill : Icons.bookmark_outlined;
}
