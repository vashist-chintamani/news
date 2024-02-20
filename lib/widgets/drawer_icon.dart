import 'package:tyrios_news_app/utilities/common_exports.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({super.key});

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: appController.toggle,
      child: const Icon(Icons.menu_outlined, size: 24),
    ),
  );
}
