import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

class SignUpWithPhone extends StatelessWidget {
  final String phone;

  const SignUpWithPhone({super.key, required this.phone});

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
                        inputTitle: strings.firstName,
                        textCapitalization: TextCapitalization.sentences,
                        autofillHints: const [AutofillHints.namePrefix],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return strings.required;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        inputTitle: strings.lastName,
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
                        initialText: phone,
                        inputTitle: strings.mobileNumber,
                        keyboardType: TextInputType.phone,
                        autofillHints: const [AutofillHints.telephoneNumber],
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: context.getScreenWidth(1),
                        child: PrimaryButton(
                          text: strings.continueBtn,
                          onTap: () => context.pushNamedAndRemoveUntil(null,
                              screen: loginController.successCallbackScreen),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
