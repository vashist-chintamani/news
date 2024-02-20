import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

class LoginWithEmailAndPhoneWidget extends StatelessWidget {
  const LoginWithEmailAndPhoneWidget({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
          final ConnectivityResult? result = snapshot.data;
          if (result == ConnectivityResult.none) {
            return Padding(
              padding: const EdgeInsets.only(top: 88.0),
              child: NoInternetConnection(
                tryAgain: strings.tryAgain,
                noInternetConnectionText: strings.noInternetConnection,
              ),
            );
          }
          if (result == ConnectivityResult.mobile) {
            return const LoginWithMobileTablet();
          } else if (result == ConnectivityResult.wifi) {
            return const LoginWithMobileTablet();
          } else if (result == null) {
            return const LoginWithMobileTablet();
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 88.0),
              child: NoInternetConnection(
                tryAgain: strings.tryAgain,
                noInternetConnectionText: strings.noInternetConnection,
              ),
            );
          }
        },
      );
}

class LoginWithMobileTablet extends StatelessWidget {
  const LoginWithMobileTablet({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isTablet) {
      if (context.isPortrait) {
        return const LoginWithEmailPhoneWidgetMobile();
      } else {
        return Row(
          children: [
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Expanded(flex: 3, child: loginController.onboardingWidget!),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            const Expanded(
              flex: 4,
              child: LoginWithEmailPhoneWidgetMobile(),
            ),
          ],
        );
      }
    } else {
      return const LoginWithEmailPhoneWidgetMobile();
    }
  }
}

class LoginWithEmailPhoneWidgetMobile extends StatelessWidget {
  const LoginWithEmailPhoneWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> typesOfLogin = [
      {
        "textColor": Colors.black,
        "text": strings.continueWithGoogle,
        "prefixIcon": SvgPicture.string(SvgIcons.google),
        "backgroundColor": Colors.white,
        "onTap": () {},
      },
      {
        "textColor": Colors.white,
        "text": strings.continueWithApple,
        "backgroundColor": const Color(0XFF2D2C2F),
        "prefixIcon": SvgPicture.string(SvgIcons.apple),
        "onTap": () {},
      },
      {
        "textColor": Colors.white,
        "text": strings.continueWithFacebook,
        "backgroundColor": const Color(0XFF1877F2),
        "prefixIcon": SvgPicture.string(SvgIcons.facebook),
        "onTap": () {},
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (context.isTablet && context.isLandscape) ...{
            const SizedBox(height: 48),
          },
          Text(
            strings.verifyIdentity,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          AppTextField(
            inputTitle: strings.enterEmail,
            placeholder: strings.brennaGmail,
            focusNode: AlwaysDisabledFocusNode(),
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            onTap: () => context.showAppGeneralDialog(
              child: const EmailAuthentication(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(child: Divider(thickness: 0.5)),
              const SizedBox(width: 20),
              Text(
                strings.or,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 30),
              const Expanded(child: Divider(thickness: 0.5))
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            disable: true,
            isExpanded: true,
            text: strings.proceedForVerification,
          ),
          const SizedBox(height: 24),
          SecondaryButton(
            isExpanded: true,
            text: strings.verifyWithPhoneNumber,
            onTap: () => context.showAppGeneralDialog(
              child: const MobileAuthentication(),
            ),
          ),
          const SizedBox(height: 12),
          ...typesOfLogin.asMap().entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Builder(
                    builder: (context) {
                      if (e.key == 0 && !context.isDarkMode) {
                        return SecondaryButton(
                          isExpanded: true,
                          text: e.value['text'] as String,
                          borderColor: context.primaryColorDark,
                          onTap: e.value['onTap'] as VoidCallback,
                          textColor: e.value['textColor'] as Color,
                          prefixIcon: e.value['prefixIcon'] as Widget,
                          backgroundColor: e.value['backgroundColor'] as Color,
                        );
                      }
                      return PrimaryButton(
                        isExpanded: true,
                        text: e.value['text'] as String,
                        onTap: e.value['onTap'] as VoidCallback,
                        textColor: e.value['textColor'] as Color,
                        prefixIcon: e.value['prefixIcon'] as Widget,
                        backgroundColor: e.value['backgroundColor'] as Color,
                      );
                    },
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
