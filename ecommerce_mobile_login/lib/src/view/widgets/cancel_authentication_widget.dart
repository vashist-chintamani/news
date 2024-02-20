import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

class CancelAuthenticationWidget extends StatelessWidget {
  const CancelAuthenticationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(strings.cancelConfirmation),
              content: Text(strings.cancelAuthenticationProcessDescription),
              actions: [
                CupertinoDialogAction(
                  child: Text(
                    strings.cancel,
                    style: const TextStyle(color: Colors.red),
                  ),
                  onPressed: () => context
                    ..pop()
                    ..pop(),
                ),
                CupertinoDialogAction(
                  onPressed: context.pop,
                  child: Text(strings.continueText),
                ),
              ],
            );
          },
        );
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: strings.cancel,
                style: const TextStyle(fontSize: 18),
              ),
              const WidgetSpan(child: SizedBox(width: 4)),
              const WidgetSpan(
                child: Icon(CupertinoIcons.clear, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
