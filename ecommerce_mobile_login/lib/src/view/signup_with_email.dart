import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

class SignUpWithEmail extends StatelessWidget {
  final String email;

  const SignUpWithEmail({super.key, required this.email});

  @override
  Widget build(BuildContext context) => AppScaffold(
        showBackButton: false,
        showMiddleWidgetAlways: true,
        title: loginController.getAppName,
        middle: context.isAndroid ? Text(loginController.getAppName) : null,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: context.getScreenWidth(1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        strings.welcome,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        strings.helpUsToKnowYouBetter,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      AppTextField(
                        placeholder: "Eg: Someone",
                        inputTitle: strings.firstName,
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.namePrefix],
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return strings.required;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        placeholder: "Eg: Someone",
                        inputTitle: strings.lastName,
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.nameSuffix],
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return strings.required;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        enable: false,
                        initialText: email,
                        inputTitle: strings.email,
                        autofillHints: const [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return strings.required;
                          }
                          if (!value.isValidEmail) {
                            return strings.emailValidate;
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 28),
                      PrimaryButton(
                        isExpanded: true,
                        text: strings.continueBtn,
                        onTap: () => context.pushNamedAndRemoveUntil(null,
                            screen: loginController.successCallbackScreen),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
