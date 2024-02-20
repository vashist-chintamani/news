import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_app_platform_widgets/mobile_app_platform_widgets.dart';

enum ToastType { success, error, info }

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

extension TYRIOSNavigationBuildContextExtensions on BuildContext {
  /// NAVIGATION METHODS
  void pop() => Navigator.of(this).pop();

  void mayBePop() async => await Navigator.of(this).maybePop();

  Future<void> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  void popAndPushNamed(String routeName, {Object? arguments}) =>
      Navigator.popAndPushNamed(this, routeName, arguments: arguments);

  void pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: arguments);

  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false,
          arguments: arguments);
}

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  Brightness get brightness => Theme.of(this).brightness;

  double getScreenHeight(double value) =>
      MediaQuery.of(this).size.height * value;

  double getScreenWidth(double value) => MediaQuery.of(this).size.width * value;

  String get languageCode =>
      View.of(this).platformDispatcher.locale.languageCode;

  bool get isIOS => true;

  bool get isAndroid => false;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  AlwaysDisabledFocusNode get disableFocusNode => AlwaysDisabledFocusNode();

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get minScreenSize =>
      min(MediaQuery.of(this).size.height, MediaQuery.of(this).size.width);

  double get maxScreenSize =>
      max(MediaQuery.of(this).size.height, MediaQuery.of(this).size.width);

  ///COLORS
  Color get focusColor =>
      isIOS ? CupertinoColors.black : Theme.of(this).focusColor;

  Color get cardColor => Theme.of(this).cardColor;

  Color get hintColor => Theme.of(this).hintColor;

  Color get canvasColor => Theme.of(this).canvasColor;

  Color get primaryColor => isIOS
      ? CupertinoTheme.of(this).primaryColor
      : Theme.of(this).primaryColor;

  Color get dividerColor => Theme.of(this).dividerColor;

  Color get disabledColor => Theme.of(this).disabledColor;

  Color get highlightColor => Theme.of(this).highlightColor;

  Color get textDisabledColor => const Color(0XFF969A9E);

  Color get secondaryColor => Theme.of(this).secondaryHeaderColor;

  Color get unselectedWidgetColor => Theme.of(this).unselectedWidgetColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get scaffoldBackgroundColor => isIOS
      ? Theme.of(this).scaffoldBackgroundColor
      : CupertinoTheme.of(this).scaffoldBackgroundColor;

  Route<dynamic> appPageRoute(Widget Function(BuildContext) route) => isIOS
      ? CupertinoPageRoute(builder: route)
      : MaterialPageRoute(builder: route);

  void postFrameCallback(VoidCallback callBack) =>
      WidgetsBinding.instance.addPostFrameCallback((_) => callBack());

  void unFocusKeyboard() =>
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

  void setAppTheme(void Function(ThemeMode themeMode) setThemeCallback) =>
      setThemeCallback(isDarkMode ? ThemeMode.light : ThemeMode.dark);

  dynamic showAppLoaderDialog(
          {Color? barrierColor,
          String? subTitle,
          String? title,
          VoidCallback? cancel}) =>
      showAppGeneralDialog(
        barrierColor: barrierColor,
        child: SizedBox(
          height: 120,
          child: Center(
            child: CircleAvatar(
              backgroundColor: isDarkMode
                  ? const Color(0XFF2C2C2C)
                  : const Color(0XFFE9EBEB).withOpacity(0.8),
              radius: 32,
              child: const AppLoader(),
            ),
          ),
        ),
      );

  Future<dynamic> showAppGeneralDialog({
    required Widget child,
    Color? barrierColor,
    bool barrierDismissible = false,
  }) async =>
      await showGeneralDialog(
        context: this,
        barrierLabel: "",
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor ?? Colors.transparent.withOpacity(0.4),
        pageBuilder: (context, animation, secondaryAnimation) => child,
      );

  /// NAVIGATION METHODS
  void _popScreen() => Navigator.of(this).pop();

  Future<void> showModelBottomSheet(
      Widget title, List<Widget> actionButtons, String cancelText,
      {bool cancelButtonRequired = false}) async {
    if (isIOS) {
      return showCupertinoModalPopup(
        context: this,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: title,
          actions: actionButtons,
          cancelButton: cancelButtonRequired
              ? CupertinoActionSheetAction(
                  onPressed: _popScreen,
                  child: Text(
                    cancelText,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              : null,
        ),
      );
    }
    return showModalBottomSheet<dynamic>(
      elevation: 10,
      context: this,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (ctx) => Wrap(
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          title,
          ...actionButtons,
          if (cancelButtonRequired) ...{
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Center(
                  child: Text(cancelText, overflow: TextOverflow.ellipsis)),
              onTap: _popScreen,
            ),
          },
        ],
      ),
    );
  }

  /// SCREEN RESOLUTION METHODS
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isTablet =>
      MediaQueryData.fromView(View.of(this)).size.shortestSide > 600;

  void setPortraitMode() {
    if (!isTablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  ScaffoldMessengerState get _scaffoldMessenger => ScaffoldMessenger.of(this);

  void hideSnackbar() => _scaffoldMessenger.hideCurrentSnackBar();

  void removeSnackbar() => _scaffoldMessenger.removeCurrentSnackBar();

  void showStatusSnackBar({
    required String title,
    String? subTitle,
    required ToastType type,
  }) {
    final Color color = type == ToastType.success
        ? const Color(0xFF259214)
        : type == ToastType.error
            ? const Color(0xFFCC2708)
            : const Color(0xFF3A0A00);
    final String icon = type == ToastType.success
        ? SvgIcons.checkCircle
        : type == ToastType.error
            ? SvgIcons.warning
            : SvgIcons.checkCircle;
    unFocusKeyboard();
    if (isIOS) {
      AppDialog.showAlertDialog(
        context: this,
        title: title,
        actions: [
          TextButton(
            onPressed: pop,
            child: const Text(
              "CLOSE",
              style: TextStyle(
                  fontSize: 16, color: Colors.red, fontWeight: FontWeight.w500),
            ),
          )
        ],
      );
    } else {
      hideSnackbar();
      removeSnackbar();
      _scaffoldMessenger.showSnackBar(
        SnackBar(
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
          showCloseIcon: true,
          closeIconColor: const Color(0xFF2C2C2C),
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: getScreenHeight(1) -
                (isTablet
                    ? isLandscape
                        ? getScreenHeight(0.18)
                        : getScreenHeight(0.14)
                    : getScreenHeight(0.34)),
          ),
          backgroundColor: const Color(0xFFEBE6CA),
          content: Padding(
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ColoredBox(
                  color: color,
                  child: const SizedBox(
                    width: 16,
                    height: 80,
                  ),
                ),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 8),
                      SvgPicture.string(icon, color: color),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: color,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
