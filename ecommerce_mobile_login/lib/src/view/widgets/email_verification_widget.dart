import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

final PageController _pageController = PageController();
final ValueNotifier<String> _emailValueNotifier = ValueNotifier("");
final ValueNotifier<String> _passwordControllerNotifier = ValueNotifier("");

set _animateToPage(int index) => _pageController.animateToPage(
      index,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );

set _jumpToPage(int index) => _pageController.jumpToPage(index);

class EmailAuthentication extends StatelessWidget {
  const EmailAuthentication({super.key});

  @override
  Widget build(BuildContext context) => Material(
        child: GestureDetector(
          onPanDown: (_) => context.unFocusKeyboard(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: context.isTablet
                ? context.isLandscape
                    ? Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                Expanded(
                                  flex: 3,
                                  child: loginController.onboardingWidget!,
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                          const Expanded(
                            flex: 4,
                            child: EmailAuthenticationMobile(),
                          ),
                        ],
                      )
                    : const EmailAuthenticationMobile()
                : const EmailAuthenticationMobile(),
          ),
        ),
      );
}

class EmailAuthenticationMobile extends StatelessWidget {
  const EmailAuthenticationMobile({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 52),
          const CancelAuthenticationWidget(),
          const SizedBox(height: 24),
          Text(
            strings.verifyIdentity,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                SingleChildScrollView(child: _EnterEmail()),
                SingleChildScrollView(child: _EmailOTPVerification()),
                SingleChildScrollView(child: _LoginWithPassword()),
                SingleChildScrollView(child: _TwoStepVerification()),
              ],
            ),
          ),
        ],
      );
}

class _EnterEmail extends StatelessWidget {
  const _EnterEmail();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          AppTextField(
            autofocus: true,
            inputTitle: strings.enterEmail,
            placeholder: strings.enterEmail,
            onChangeNotifier: _emailValueNotifier,
            focusNode: FocusNode()..requestFocus(),
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            textCapitalization: TextCapitalization.none,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [FilteringTextInputFormatter.deny(" ")],
            validator: (String? value) {
              if (value!.isEmpty) {
                return strings.required;
              }
              if (!value.isValidEmail) {
                return "Invalid Email address";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ValueListenableBuilder(
            valueListenable: _emailValueNotifier,
            builder: (context, email, child) => PrimaryButton(
              isExpanded: true,
              text: strings.proceedForVerification,
              disable: [email.isEmpty, !email.isValidEmail].contains(true),
              onTap: () {
                context.showAppLoaderDialog();

                loginController
                    .loginWithPhoneEmailViaOTP(phoneEmail: email)
                    .then(
                  (value) {
                    context.pop();
                    if (value.loginModel != null) {
                      if (value.loginModel!.loginType == "otp") {
                        /// SETTING TO MOVE TO LOGIN WITH OTP SCREEN
                        _animateToPage = 1;
                      } else {
                        /// SETTING TO MOVE TO LOGIN WITH PASSWORD SCREEN
                        _jumpToPage = 2;
                      }
                    } else if (value.errorMessage != null) {
                      context.showStatusSnackBar(
                          title: value.errorMessage!, type: ToastType.error);
                    }
                  },
                );
              },
            ),
          ),
        ],
      );
}

class _EmailOTPVerification extends StatelessWidget {
  const _EmailOTPVerification();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> otpCodeControllerNotifier = ValueNotifier("");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          maxLength: 4,
          autofocus: true,
          counter: const SizedBox.shrink(),
          keyboardType: TextInputType.number,
          focusNode: FocusNode()..requestFocus(),
          inputTitle: strings.enterVerificationCode,
          placeholder: strings.enterVerificationCode,
          autofillHints: const [AutofillHints.oneTimeCode],
          onChangeNotifier: otpCodeControllerNotifier,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value!.length != 4) {
              return strings.pleaseEnterADigitOTP;
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        ValueListenableBuilder(
          valueListenable: otpCodeControllerNotifier,
          builder: (context, otpCode, child) => PrimaryButton(
            isExpanded: true,
            text: strings.verify,
            disable: otpCode.length != 4,
            onTap: () {
              context.showAppLoaderDialog();
              loginController
                  .loginWithOtpOrPassword(otp: otpCode, password: null)
                  .then(
                (value) {
                  context.pop();

                  if (value.errorMessage != null) {
                    context.showStatusSnackBar(
                      title: value.errorMessage ??
                          "Something went wrong, please try again!",
                      type: ToastType.error,
                    );
                  } else {
                    if (value.userModel != null &&
                        value.userModel!.name == null &&
                        value.userModel!.preName == null) {
                      context.pushNamedAndRemoveUntil(Routes.signUpWithEmail,
                          arguments: _emailValueNotifier.value);
                    } else {
                      context.pushNamedAndRemoveUntil(null,
                          screen: loginController.successCallbackScreen);
                    }
                  }
                },
              );
            },
          ),
        ),
        const SizedBox(height: 28),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: strings.checkYourInboxWeHaveSentaVerificationCodeTo,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: context.primaryColorDark,
                    ),
                  ),
                  TextSpan(
                    text: "\n${_emailValueNotifier.value}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: context.primaryColorDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                context.unFocusKeyboard();
                _animateToPage = 0;
              },
              child: Text(
                strings.changeEmail,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0XFF7A35FF),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Divider(thickness: 1),
        const SizedBox(height: 24),
        Text(
          strings.havenReceivedYourVerificationCode,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () {
            context.showAppLoaderDialog();
            loginController
                .loginWithPhoneEmailViaOTP(
                    phoneEmail: _emailValueNotifier.value, resendOTP: true)
                .then((_) => context.pop());
          },
          child: Text(
            strings.resendCode,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0XFF7A35FF),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginWithPassword extends StatelessWidget {
  const _LoginWithPassword();

  @override
  Widget build(BuildContext context) {
    bool doNotShowPassword = true;
    _passwordControllerNotifier.value = "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatefulBuilder(
          builder: (context, setState) => AppTextField(
            obscureText: doNotShowPassword,
            keyboardType: TextInputType.text,
            inputTitle: strings.enterPassword,
            focusNode: FocusNode()..requestFocus(),
            textCapitalization: TextCapitalization.none,
            autofillHints: const [AutofillHints.password],
            onChangeNotifier: _passwordControllerNotifier,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            suffix: GestureDetector(
              onTap: () =>
                  setState(() => doNotShowPassword = !doNotShowPassword),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(doNotShowPassword
                    ? CupertinoIcons.eye_slash
                    : CupertinoIcons.eye),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return strings.required;
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 8),
        Button(
          onTap: () {},
          child: Text(
            strings.forgotPassword,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: context.primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(height: 24),
        ValueListenableBuilder(
          valueListenable: _passwordControllerNotifier,
          builder: (context, password, child) => PrimaryButton(
            isExpanded: true,
            text: strings.verify,
            disable: password.isEmpty,
            onTap: () {
              context.showAppLoaderDialog();
              loginController
                  .loginWithOtpOrPassword(
                      otp: null, password: _passwordControllerNotifier.value)
                  .then(
                (value) {
                  context.pop();
                  if (value.errorMessage != null) {
                    context.showStatusSnackBar(
                        title: value.errorMessage!, type: ToastType.error);
                  }

                  if (value.doubleOtpVerificationEnable != null &&
                      value.doubleOtpVerificationEnable!) {
                    /// SETTING TO MOVE TO TWO-STEP VERIFICATION SCREEN
                    _animateToPage = 3;
                  } else if (value.errorMessage == null) {
                    context.pushNamedAndRemoveUntil(null,
                        screen: loginController.successCallbackScreen);
                  }
                },
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Expanded(child: Divider()),
            const SizedBox(width: 20),
            Text(strings.orGet),
            const SizedBox(width: 20),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 24),
        SecondaryButton(
          isExpanded: true,
          text: strings.verificationCode,
          onTap: () {
            context.showAppLoaderDialog();
            loginController
                .loginWithPhoneEmailViaOTP(
                    phoneEmail: _emailValueNotifier.value, resendOTP: true)
                .then((_) {
              context.pop();
              _animateToPage = 1;
            });
          },
        ),
      ],
    );
  }
}

class _TwoStepVerification extends StatelessWidget {
  const _TwoStepVerification();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> twoFactorOTPCodeNotifier = ValueNotifier("");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.twoFactorAuthentication,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        AppTextField(
          maxLength: 6,
          autofocus: true,
          counter: const SizedBox.shrink(),
          keyboardType: TextInputType.number,
          focusNode: FocusNode()..requestFocus(),
          inputTitle: strings.enterAuthenticatorCode,
          onChangeNotifier: twoFactorOTPCodeNotifier,
          autofillHints: const [AutofillHints.oneTimeCode],
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value!.length != 6) {
              return strings.pleaseEnterADigitOTP;
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        ValueListenableBuilder(
          valueListenable: twoFactorOTPCodeNotifier,
          builder: (context, twoFactorOTPCode, child) => PrimaryButton(
            isExpanded: true,
            text: strings.verify,
            disable: twoFactorOTPCode.length != 6,
            onTap: () {
              context.showAppLoaderDialog();
              loginController
                  .loginWithOtpOrPassword(
                      otp: null,
                      twoStepVerification: true,
                      password: _passwordControllerNotifier.value,
                      twoStepVerificationOTP: twoFactorOTPCodeNotifier.value)
                  .then(
                (value) {
                  context.pop();
                  if (value.errorMessage != null) {
                    context.showStatusSnackBar(
                        title: value.errorMessage!, type: ToastType.error);
                  } else {
                    context
                      ..pushNamedAndRemoveUntil(null,
                          screen: loginController.successCallbackScreen)
                      ..showStatusSnackBar(
                        type: ToastType.success,
                        title: "Verification successful!",
                      );
                  }
                },
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        Text(
          strings.pleaseEnterTheAuthenticatorCodeWeSentYouToVerifyYourIdentity,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 20),
        const Divider(thickness: 2),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              strings.problemWithYourCode,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {},
              child: Text(
                strings.learnMore,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0XFF7A34FF),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
