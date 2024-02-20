import 'package:tyrios_news_app/utilities/common_exports.dart';

class AppTheme {
  factory AppTheme() => _singleton;

  static final AppTheme _singleton = AppTheme._internal();

  AppTheme._internal();

  static const Color _white = Colors.white;
  static const Color _blackBG = Color(0XFF0E0E0F);
  static const Color _secondaryColor = _primaryColor;
  static const Color _errorColor = Color(0XFFCC2708);
  static const Color _lightGrayBG = Color(0XFFE5E4E6);
  static const Color _darkGreyBG = Color(0xFF2D2C2F);
  static const Color _primaryColor = Color(0xFF9761FF);
  static const Color mediumColor = Color(0XFFCAAEFF);
  static const Color _lightColor = Color(0XFFEBE6CA);
  static const Color _mediumGrayBG = Color(0XFF969A9E);
  static const Color _neutralColor = Color(0XFFF5F5F5);

  final MaterialColor _primarySwatchLight = MaterialColor(
    _primaryColor.value,
    const <int, Color>{
      10: Color(0XFFFCFAFF),
      30: Color(0XFFF6F2FF),
      50: Color(0xFFF1EBFF),
      100: Color(0xFFE4D7FF),
      200: Color(0xFFCAAEFF),
      300: Color(0xFFAF86FF),
      400: Color(0xFF9761FF),
      500: Color(0xFF7A35FF),
      600: Color(0xFF622ACC),
      700: Color(0xFF492099),
      800: Color(0xFF2B135A),
      900: Color(0xFF180B33),
    },
  );

  ThemeData get light => ThemeData(
        canvasColor: _white,
        focusColor: _blackBG,
        fontFamily: 'Poppins',
        primaryColor: _primaryColor,
        disabledColor: _lightGrayBG,
        dividerColor: _primaryColor,
        brightness: Brightness.light,
        primaryColorDark: _darkGreyBG,
        iconTheme: const IconThemeData(color: _darkGreyBG),
        buttonTheme: const ButtonThemeData(disabledColor: _lightGrayBG),
        drawerTheme: const DrawerThemeData(
          elevation: 0,
          backgroundColor: _neutralColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: _darkGreyBG),
          bodySmall: TextStyle(color: _darkGreyBG),
          bodyMedium: TextStyle(color: _darkGreyBG),
          titleLarge: TextStyle(color: _darkGreyBG),
          titleMedium: TextStyle(color: _darkGreyBG),
        ),
        primaryTextTheme: const TextTheme(
          bodyLarge: TextStyle(color: _darkGreyBG),
          bodySmall: TextStyle(color: _darkGreyBG),
          bodyMedium: TextStyle(color: _darkGreyBG),
          titleLarge: TextStyle(color: _darkGreyBG),
          titleMedium: TextStyle(color: _darkGreyBG),
        ),
        primarySwatch: _primarySwatchLight,
        secondaryHeaderColor: _darkGreyBG,
        unselectedWidgetColor: _darkGreyBG,
        scaffoldBackgroundColor: _neutralColor,
        cupertinoOverrideTheme: lightCupertinoTheme,
        splashColor: _primaryColor.withOpacity(0.1),
        highlightColor: _primaryColor.withOpacity(0.0001),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Color(0xFFFFFFFF),
          selectedItemColor: _primaryColor,
          unselectedItemColor: _darkGreyBG,
          selectedIconTheme: IconThemeData(
            color: _primaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: _darkGreyBG,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            color: _primaryColor,
            fontFamily: "Poppins",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            color: _darkGreyBG,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(_primaryColor),
        ),
        listTileTheme: ListTileThemeData(
          iconColor: _darkGreyBG,
          selectedColor: _primaryColor,
          selectedTileColor: _primaryColor.withOpacity(0.1),
          titleTextStyle: const TextStyle(
            fontSize: 16,
            color: _darkGreyBG,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: _neutralColor,
          foregroundColor: _neutralColor,
          iconTheme: IconThemeData(color: _darkGreyBG),
          titleTextStyle: TextStyle(
            fontSize: 34,
            color: _darkGreyBG,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(_white),
          checkColor: MaterialStateProperty.all(_primaryColor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          side: MaterialStateBorderSide.resolveWith(
            (_) => const BorderSide(width: 1.5, color: _primaryColor),
          ),
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
              // backgroundColor: MaterialStatePropertyAll(_darkGreyBG),
              ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _white,
          errorStyle: const TextStyle(
            fontSize: 13,
            color: _errorColor,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: const TextStyle(
            fontSize: 16,
            color: _mediumGrayBG,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: _mediumGrayBG),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: _mediumGrayBG),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: _darkGreyBG, width: 2),
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: _primaryColor,
          labelPadding: EdgeInsets.zero,
          unselectedLabelColor: _darkGreyBG,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2, color: _primaryColor),
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
          labelStyle: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  ThemeData get dark => ThemeData(
        /*
    focusColor: const Color(0xFF000000),
        canvasColor: const Color(0xFFFFFFFF),
        dividerColor: const Color(0xFFD3D8DD),
        primaryColor: const Color(0xFFFFD000),
        disabledColor: const Color(0xFF9EA4AB),
        indicatorColor: const Color(0xFF888E94),
        unselectedWidgetColor: AppColors.backBlack,
        secondaryHeaderColor: const Color(0xFF2D3138),
        scaffoldBackgroundColor: const Color(0xffF5F5F5),
        // scaffoldBackgroundColor: const Color(0xFFE5E8ED),
        hintColor: const Color.fromRGBO(107, 114, 120, 100),
        iconTheme: const IconThemeData(color: Colors.black),
        splashColor: const Color(0xFFFFD000).withOpacity(0.1),
        highlightColor: const Color(0xFFFFD000).withOpacity(0.1),
        primaryColorDark: const Color.fromRGBO(58, 64, 70, 100),
        cardTheme: const CardTheme(
            color: Color(0xFFFFFFFF), shape: RoundedRectangleBorder()),
        buttonTheme: const ButtonThemeData(buttonColor: Color(0xFFE5E8ED)),
        listTileTheme: const ListTileThemeData(iconColor: Color(0xFF000000)),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Color(0xFF000000)),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.black),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 29,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600,
            fontFamily: "LiebherrText",
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w900,
            fontFamily: "LiebherrHead",
          ),
          displaySmall: TextStyle(
            fontSize: 20,
            color: Color(0xFF000000),
            fontStyle: FontStyle.normal,
            fontFamily: "LiebherrText",
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w700,
            fontFamily: "LiebherrText",
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            color: Color(0xFF000000),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontFamily: "LiebherrText",
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF000000),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontFamily: "LiebherrText",
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            color: Color(0xFF888E94),
            fontWeight: FontWeight.w700,
            fontFamily: "LiebherrText",
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w400,
            fontFamily: "LiebherrText",
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Color(0xFF000000),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontFamily: "LiebherrText",
          ),
          bodyLarge: TextStyle(
            fontSize: 14,
            color: Color(0xFF888E94),
            fontWeight: FontWeight.w600,
            fontFamily: "LiebherrText",
          ),
          bodyMedium: TextStyle(
            fontSize: 12,
            color: Color(0xFF000000),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontFamily: "LiebherrText",
          ),
        ),
        scrollbarTheme: const ScrollbarThemeData(
          trackColor: MaterialStatePropertyAll(Color(0xFFF0F3F6)),
          thumbColor: MaterialStatePropertyAll(Color(0xFFBDC4CA)),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Color(0xFF9EA4AB),
          selectedItemColor: Color(0xFF000000),
          unselectedItemColor: Color(0xFF9EA4AB),
          selectedLabelStyle: TextStyle(
            fontSize: 10,
            color: Color(0xFF000000),
            fontFamily: "LiebherrText",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 10,
            color: Color(0xFF9EA4AB),
            fontFamily: "LiebherrText",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: false,
          foregroundColor: Color(0xFFE5E8ED),
          backgroundColor: Color(0xFFF9FAFB),
          iconTheme: IconThemeData(color: Color(0xFF000000), size: 20),
          actionsIconTheme: IconThemeData(color: Color(0xFF000000), size: 20),
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Color(0xFF000000),
            fontFamily: "LiebherrText",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          side: const BorderSide(color: Colors.black),
          checkColor: MaterialStateProperty.all(AppColors.black),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          fillColor: Color(0xFFFFFFFF),
          labelStyle: TextStyle(
            fontSize: 18,
            color: Color(0xFF000000),
            fontFamily: "LiebherrText",
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0xFF888E94),
            fontFamily: "LiebherrText",
            fontWeight: FontWeight.w400,
          ),
          errorStyle: TextStyle(
            fontSize: 14,
            fontFamily: "LiebherrText",
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Color.fromRGBO(81, 88, 93, 100)),
            borderRadius: BorderRadius.zero,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(width: 1, color: Color(0xFF000000)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(width: 1, color: Color(0xFF000000)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Color(0xFF000000),
          backgroundColor: Color(0xFFFFD000),
          extendedTextStyle: TextStyle(
            fontSize: 18,
            color: Color(0xFF000000),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontFamily: "LiebherrText",
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            iconColor: const MaterialStatePropertyAll(Colors.black),
            minimumSize: const MaterialStatePropertyAll(Size(44, 44)),
            overlayColor: MaterialStatePropertyAll(
                const Color(0xFFFFD000).withOpacity(0.1)),
            side:
                const MaterialStatePropertyAll(BorderSide(color: Colors.black)),
            shape: const MaterialStatePropertyAll(ContinuousRectangleBorder()),
            textStyle: const MaterialStatePropertyAll(
              TextStyle(
                fontSize: 14,
                color: Color(0xFF000000),
                fontFamily: "LiebherrText",
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(Size(44, 44)),
            overlayColor:
                MaterialStatePropertyAll(Colors.black.withOpacity(0.03)),
            shape: const MaterialStatePropertyAll(ContinuousRectangleBorder()),
            foregroundColor: const MaterialStatePropertyAll(Color(0xFF000000)),
            backgroundColor: const MaterialStatePropertyAll(Color(0xFFFFD000)),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16),
            ),
            textStyle: const MaterialStatePropertyAll(
              TextStyle(
                fontSize: 14,
                color: Color(0xFF000000),
                fontFamily: "LiebherrText",
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelPadding: EdgeInsets.zero,
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          labelColor: Color(0xFF000000),
          unselectedLabelColor: Color.fromRGBO(81, 88, 93, 100),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2,
              color: Color(0xFFFFD000),
            ),
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            letterSpacing: 0.78,
            fontWeight: FontWeight.w700,
            color: Color(0xFF000000),
            fontFamily: "LiebherrText",
          ),
          labelStyle: TextStyle(
            fontSize: 16,
            letterSpacing: 0.78,
            fontWeight: FontWeight.w700,
            color: Color(0xFF51585D),
            fontFamily: "LiebherrText",
          ),
        ),
    * */

        focusColor: _white,
        fontFamily: 'Poppins',
        canvasColor: _blackBG,
        hoverColor: Colors.red,
        primaryColorDark: _white,
        brightness: Brightness.dark,
        primaryColor: _primaryColor,
        dividerColor: _primaryColor,
        disabledColor: _lightGrayBG,
        primarySwatch: _primarySwatchLight,
        scaffoldBackgroundColor: _blackBG,
        cardColor: const Color(0xff1A1A1A),
        secondaryHeaderColor: _secondaryColor,
        unselectedWidgetColor: _secondaryColor,
        cupertinoOverrideTheme: darkCupertinoTheme,
        splashColor: _primaryColor.withOpacity(0.1),
        iconTheme: const IconThemeData(color: _white),
        highlightColor: _primaryColor.withOpacity(0.1),
        drawerTheme: const DrawerThemeData(
          elevation: 0,
          backgroundColor: _blackBG,
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
              // backgroundColor: MaterialStatePropertyAll(_white),
              ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: _blackBG,
          selectedItemColor: _primaryColor,
          unselectedItemColor: _white,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            color: _mediumGrayBG,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            color: _white,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
        listTileTheme: ListTileThemeData(
          iconColor: _white,
          selectedColor: _primaryColor,
          selectedTileColor: _primaryColor.withOpacity(0.1),
          titleTextStyle: const TextStyle(
            fontSize: 16,
            color: _white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          foregroundColor: _blackBG,
          backgroundColor: _blackBG,
          iconTheme: IconThemeData(color: _white),
          titleTextStyle: TextStyle(
            fontSize: 34,
            color: _white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(_blackBG),
          checkColor: MaterialStateProperty.all(_secondaryColor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          side: MaterialStateBorderSide.resolveWith(
            (_) => const BorderSide(
              width: 1.5,
              color: _secondaryColor,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _blackBG,
          errorStyle: const TextStyle(
            fontSize: 13,
            color: _errorColor,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: const TextStyle(
            fontSize: 16,
            color: _mediumGrayBG,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: _white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: _white),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: _white, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: _primaryColor,
          labelPadding: EdgeInsets.zero,
          unselectedLabelColor: _white,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2, color: _primaryColor),
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            color: _white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
          labelStyle: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  CupertinoThemeData get lightCupertinoTheme => const CupertinoThemeData(
        applyThemeToAll: true,
        primaryColor: _primaryColor,
        brightness: Brightness.light,
        scaffoldBackgroundColor: _white,
        barBackgroundColor: _neutralColor,
        primaryContrastingColor: _primaryColor,
      );

  CupertinoThemeData get darkCupertinoTheme => const CupertinoThemeData(
        applyThemeToAll: true,
        primaryColor: _primaryColor,
        brightness: Brightness.dark,
        barBackgroundColor: _blackBG,
        scaffoldBackgroundColor: _blackBG,
        primaryContrastingColor: _primaryColor,
      );
}
