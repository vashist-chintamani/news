import 'package:mobile_app_platform_widgets/common_exports.dart';

class AppLoader extends StatelessWidget {
  final double cupertinoIconSize;

  const AppLoader({super.key, this.cupertinoIconSize = 15});

  @override
  Widget build(BuildContext context) => context.isIOS
      ? CupertinoActivityIndicator(radius: cupertinoIconSize)
      : const CircularProgressIndicator();
}
