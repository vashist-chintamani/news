// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `News`
  String get blog {
    return Intl.message(
      'News',
      name: 'blog',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `For you`
  String get forYou {
    return Intl.message(
      'For you',
      name: 'forYou',
      desc: '',
      args: [],
    );
  }

  /// `Imprint`
  String get imprint {
    return Intl.message(
      'Imprint',
      name: 'imprint',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelText {
    return Intl.message(
      'Cancel',
      name: 'cancelText',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `min read`
  String get minRead {
    return Intl.message(
      'min read',
      name: 'minRead',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get bookmark {
    return Intl.message(
      'Favorites',
      name: 'bookmark',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Switch Theme`
  String get theme {
    return Intl.message(
      'Switch Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Terms of use`
  String get termsOfUse {
    return Intl.message(
      'Terms of use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `No news available`
  String get noBlogsAvailable {
    return Intl.message(
      'No news available',
      name: 'noBlogsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Please choose your language`
  String get pleaseChooseYourLanguage {
    return Intl.message(
      'Please choose your language',
      name: 'pleaseChooseYourLanguage',
      desc: '',
      args: [],
    );
  }

  /// `No favourite news found`
  String get noFavouriteBlogsFound {
    return Intl.message(
      'No favourite news found',
      name: 'noFavouriteBlogsFound',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection was found. Check your connection or try again`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection was found. Check your connection or try again',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Warning: This action will permanently delete your account and any stored data, including your favorite blogs. You won't be able to recover your account or data.`
  String get warningMessage {
    return Intl.message(
      'Warning: This action will permanently delete your account and any stored data, including your favorite blogs. You won\'t be able to recover your account or data.',
      name: 'warningMessage',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message(
      'Try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `SAVE`
  String get save {
    return Intl.message(
      'SAVE',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Hello!`
  String get hello {
    return Intl.message(
      'Hello!',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Or Get`
  String get orGet {
    return Intl.message(
      'Or Get',
      name: 'orGet',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Learn More`
  String get learnMore {
    return Intl.message(
      'Learn More',
      name: 'learnMore',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE`
  String get continueBtn {
    return Intl.message(
      'CONTINUE',
      name: 'continueBtn',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email`
  String get enterEmail {
    return Intl.message(
      'Enter Email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get changeEmail {
    return Intl.message(
      'Change Email',
      name: 'changeEmail',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Login with OTP`
  String get loginWithOtp {
    return Intl.message(
      'Login with OTP',
      name: 'loginWithOtp',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enterPassword {
    return Intl.message(
      'Enter Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `brenna93@gmail.com`
  String get brennaGmail {
    return Intl.message(
      'brenna93@gmail.com',
      name: 'brennaGmail',
      desc: '',
      args: [],
    );
  }

  /// `Verify Identity`
  String get verifyIdentity {
    return Intl.message(
      'Verify Identity',
      name: 'verifyIdentity',
      desc: '',
      args: [],
    );
  }

  /// `Let's get started!`
  String get letsGetStart {
    return Intl.message(
      'Let\'s get started!',
      name: 'letsGetStart',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password`
  String get invalidPassword {
    return Intl.message(
      'Invalid password',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Phone Number`
  String get phoneValidate {
    return Intl.message(
      'Invalid Phone Number',
      name: 'phoneValidate',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code`
  String get verificationCode {
    return Intl.message(
      'Verification Code',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone Number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter Phone Number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email Address`
  String get emailValidate {
    return Intl.message(
      'Invalid Email Address',
      name: 'emailValidate',
      desc: '',
      args: [],
    );
  }

  /// `Email Verification`
  String get emailVerification {
    return Intl.message(
      'Email Verification',
      name: 'emailVerification',
      desc: '',
      args: [],
    );
  }

  /// `Verification successful!`
  String get verificationSuccessful {
    return Intl.message(
      'Verification successful!',
      name: 'verificationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get continueWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'continueWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Change Phone Number`
  String get changePhoneNumber {
    return Intl.message(
      'Change Phone Number',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email / Phone`
  String get enterEmailOrPhone {
    return Intl.message(
      'Enter Email / Phone',
      name: 'enterEmailOrPhone',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get createNewPassword {
    return Intl.message(
      'Create New Password',
      name: 'createNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Verification`
  String get mobileVerification {
    return Intl.message(
      'Mobile Verification',
      name: 'mobileVerification',
      desc: '',
      args: [],
    );
  }

  /// `2-Step verification`
  String get twoStepVerification {
    return Intl.message(
      '2-Step verification',
      name: 'twoStepVerification',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Confirmation`
  String get cancelConfirmation {
    return Intl.message(
      'Cancel Confirmation',
      name: 'cancelConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get continueWithFacebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'continueWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Password doesn't match`
  String get passwordDoesNotMatch {
    return Intl.message(
      'Password doesn\'t match',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Problem with your code?`
  String get problemWithYourCode {
    return Intl.message(
      'Problem with your code?',
      name: 'problemWithYourCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 6-digit code`
  String get enterTheSixDigitCode {
    return Intl.message(
      'Enter the 6-digit code',
      name: 'enterTheSixDigitCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter your OTP code here`
  String get enterYourOtpCodeHere {
    return Intl.message(
      'Enter your OTP code here',
      name: 'enterYourOtpCodeHere',
      desc: '',
      args: [],
    );
  }

  /// `Verify with Phone Number`
  String get verifyWithPhoneNumber {
    return Intl.message(
      'Verify with Phone Number',
      name: 'verifyWithPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter verification code`
  String get enterVerificationCode {
    return Intl.message(
      'Enter verification code',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Didn't received the OTP?`
  String get didNotReceivedTheOtp {
    return Intl.message(
      'Didn\'t received the OTP?',
      name: 'didNotReceivedTheOtp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a 6-digit OTP`
  String get pleaseEnterADigitOTP {
    return Intl.message(
      'Please enter a 6-digit OTP',
      name: 'pleaseEnterADigitOTP',
      desc: '',
      args: [],
    );
  }

  /// `Enter Authenticator Code`
  String get enterAuthenticatorCode {
    return Intl.message(
      'Enter Authenticator Code',
      name: 'enterAuthenticatorCode',
      desc: '',
      args: [],
    );
  }

  /// `Proceed for Verification`
  String get proceedForVerification {
    return Intl.message(
      'Proceed for Verification',
      name: 'proceedForVerification',
      desc: '',
      args: [],
    );
  }

  /// `Two-factor Authentication`
  String get twoFactorAuthentication {
    return Intl.message(
      'Two-factor Authentication',
      name: 'twoFactorAuthentication',
      desc: '',
      args: [],
    );
  }

  /// `Help us to know you better!`
  String get helpUsToKnowYouBetter {
    return Intl.message(
      'Help us to know you better!',
      name: 'helpUsToKnowYouBetter',
      desc: '',
      args: [],
    );
  }

  /// `An OTP has been sent to {param}`
  String anOtpHasBeenSentTo(Object param) {
    return Intl.message(
      'An OTP has been sent to $param',
      name: 'anOtpHasBeenSentTo',
      desc: '',
      args: [param],
    );
  }

  /// `Phone number should contain at least 10 digits`
  String get phoneShould {
    return Intl.message(
      'Phone number should contain at least 10 digits',
      name: 'phoneShould',
      desc: '',
      args: [],
    );
  }

  /// `An OTP has been sent to +9100000000`
  String get anOtpHasBeenSentMobile {
    return Intl.message(
      'An OTP has been sent to +9100000000',
      name: 'anOtpHasBeenSentMobile',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password here`
  String get pleaseEnterYourPasswordHere {
    return Intl.message(
      'Please enter your password here',
      name: 'pleaseEnterYourPasswordHere',
      desc: '',
      args: [],
    );
  }

  /// `An OTP has been sent to someone@xyz.com`
  String get anOtpHasBeenSentEmail {
    return Intl.message(
      'An OTP has been sent to someone@xyz.com',
      name: 'anOtpHasBeenSentEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number or email address`
  String get invalidPhoneNumberOrEmailAddress {
    return Intl.message(
      'Invalid phone number or email address',
      name: 'invalidPhoneNumberOrEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Haven't Received Your Verification Code?`
  String get havenReceivedYourVerificationCode {
    return Intl.message(
      'Haven\'t Received Your Verification Code?',
      name: 'havenReceivedYourVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Check Your Inbox! We've Sent a Verification Code to`
  String get checkYourInboxWeHaveSentaVerificationCodeTo {
    return Intl.message(
      'Check Your Inbox! We\'ve Sent a Verification Code to',
      name: 'checkYourInboxWeHaveSentaVerificationCodeTo',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again!`
  String get somethingWentWrongPleaseTryAgain {
    return Intl.message(
      'Something went wrong, please try again!',
      name: 'somethingWentWrongPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Your account has two factor authentication enabled.`
  String get yourAccountHasTwoFactorAuthenticationEnabled {
    return Intl.message(
      'Your account has two factor authentication enabled.',
      name: 'yourAccountHasTwoFactorAuthenticationEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to our virtual store where you can explore a wide range of products that you will love.`
  String get welcomeToOurVirtual {
    return Intl.message(
      'Welcome to our virtual store where you can explore a wide range of products that you will love.',
      name: 'welcomeToOurVirtual',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter the Authenticator Code We Sent You to Verify Your Identity`
  String get pleaseEnterTheAuthenticatorCodeWeSentYouToVerifyYourIdentity {
    return Intl.message(
      'Please Enter the Authenticator Code We Sent You to Verify Your Identity',
      name: 'pleaseEnterTheAuthenticatorCodeWeSentYouToVerifyYourIdentity',
      desc: '',
      args: [],
    );
  }

  /// `Cancelling the authentication process will terminate your current session and you will need to start over.`
  String get cancelAuthenticationProcessDescription {
    return Intl.message(
      'Cancelling the authentication process will terminate your current session and you will need to start over.',
      name: 'cancelAuthenticationProcessDescription',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
