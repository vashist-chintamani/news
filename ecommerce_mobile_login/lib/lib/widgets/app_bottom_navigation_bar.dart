import 'package:tyrios_news_app/utilities/common_exports.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  static Widget _returnBottomNavIcon(
    String? icon, {
    double? width,
    Color? color,
    IconData? iconData,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: iconData != null
            ? Icon(iconData, size: 20, color: color)
            : SvgPicture.string(icon!, height: 20, width: width, color: color),
      );

  static Widget _returnBottomNavIconIos(
    String? icon,
    BuildContext context, {
    Color? color,
    IconData? iconData,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 0,
            child: Divider(color: color, thickness: 2),
          ),
          const SizedBox(height: 4),
          _returnBottomNavIcon(icon, iconData: iconData, color: color),
        ],
      );

  static List<BottomNavigationBarItem> bottomNavBars(BuildContext context) {
    return [
      BottomNavigationBarItem(
        label: strings.blog,
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (context.isIOS) ...{const SizedBox(height: 4)},
            _returnBottomNavIcon(
              SvgIcons.blog,
              color: context.primaryColorDark,
            ),
          ],
        ),
        activeIcon: context.isIOS
            ? _returnBottomNavIconIos(
                SvgIcons.blog,
                color: context.primaryColor,
                context,
              )
            : _returnBottomNavIcon(
                SvgIcons.blog,
                color: context.primaryColor,
              ),
      ),
      BottomNavigationBarItem(
        label: strings.bookmark,
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (context.isIOS) ...{const SizedBox(height: 4)},
            _returnBottomNavIcon(
              null,
              iconData: AppIcons.bookmark,
              color: context.primaryColorDark,
            ),
          ],
        ),
        activeIcon: context.isIOS
            ? _returnBottomNavIconIos(
                null,
                iconData: AppIcons.bookmarkFill,
                color: context.primaryColor,
                context,
              )
            : _returnBottomNavIcon(
                null,
                iconData: AppIcons.bookmarkFill,
                color: context.primaryColor,
              ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: appController.appNavIndex,
        builder: (_, currentIndex, __) => Stack(
          children: [
            BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: currentIndex,
              items: bottomNavBars(context),
              type: BottomNavigationBarType.fixed,
              onTap: (int index) => appController.appNavIndex.value = index,
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: currentIndex == 1 ? (context.screenWidth / 2) : null,
              right: currentIndex == 2 ? 0 : null,
              child: ColoredBox(
                color: context.primaryColor,
                child: SizedBox(
                  height: 2,
                  width: context.screenWidth / 2,
                ),
              ),
            ),
          ],
        ),
      );
}
