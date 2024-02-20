import 'package:mobile_app_platform_widgets/common_exports.dart';
import 'package:mobile_app_platform_widgets/generated/l10n.dart';

class NoInternetConnection extends StatelessWidget {
  final VoidCallback? tryInternetAgainCallback;

  const NoInternetConnection({super.key, this.tryInternetAgainCallback, required String noInternetConnectionText, required String tryAgain});

  @override
  Widget build(BuildContext context) => Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Icon(Icons.wifi_off_rounded, size: 60),
              const SizedBox(height: 20),
              Text(
                S.of(context).noInternetConnection,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: context.primaryColorDark,
                ),
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                text: S.of(context).tryAgain,
                onTap: () {
                  Connectivity().checkConnectivity();
                  if (tryInternetAgainCallback != null) {
                    tryInternetAgainCallback!();
                  }
                },
              ),
            ],
          ),
        ),
      );
}
