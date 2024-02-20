import 'package:mobile_app_platform_widgets/common_exports.dart';

class AppDialog {
  static Future<dynamic> showAlertDialog({
    Widget? content,
    required String title,
    required List<Widget> actions,
    required BuildContext context,
  }) async =>
      showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if (context.isIOS) {
            return CupertinoAlertDialog(
              content: content,
              actions: actions,
              title: Text(title),
            );
          } else {
            return AlertDialog(
              content: content,
              actions: actions,
              title: Text(title),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }
        },
      );
}
