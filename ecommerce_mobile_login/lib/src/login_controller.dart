import 'package:ecommerce_mobile_login/src/utils/common_exports.dart';

late BuildContext _context;

class LoginController with _LoginStateMixin, _HttpExtensions {
  factory LoginController() => _singleton;

  static final LoginController _singleton = LoginController._internal();

  LoginController._internal();

  Widget? onboardingWidget;

  late String _baseURL;
  late Response _response;
  late void Function(Map<dynamic, dynamic> object) _savedLogin;

  ({
    LoginModel? loginModel,
    UserModel? userModel,
    LoginToken? loginToken
  }) userData = (loginModel: null, userModel: null, loginToken: null);

  AsyncCallback? _loginSuccessCallback;

  bool get isLoggedIn => userData.userModel != null;

  Widget? successCallbackScreen;

  /// INITIALISE LOGIN - USED FOR INITIALISING ALL THE REQUIRED RESOURCES FOR LOGIN TO FUNCTION PROPERLY
  void initialiseLoginPackageResource({
    required String baseUrl,
    required String appName,
    required String languageCode,
    required BuildContext context,
    required void Function(Map<dynamic, dynamic> object) savedLogin,
    required ValueNotifier<ConnectivityResult?> internetConnectionNotifier,
    Map<dynamic, dynamic>? loginToken,
    AsyncCallback? loginSuccessCallback,
    Widget? successCallbackScreen,
    Widget? onboardingWidget,
  }) {
    /// SETTING THE BUILD-CONTEXT
    _context = context;

    /// SETTING THE APPLICATION NAME
    _setAppName = appName;

    /// SETTING THE BASE_URL
    _baseURL = baseUrl;

    /// SETTING THE INTERNET CONNECTION NOTIFIER
    this.internetConnectionNotifier = internetConnectionNotifier;

    /// SETTING THE LANGUAGE CODE
    setLanguageCode = languageCode;

    /// SETTING THE ONBOARDING-WIDGET
    this.onboardingWidget = onboardingWidget;

    /// PASSING SAVED HIVE LOGIN CALLBACK AND SETTING TO THE LOCAL VARIABLE SO WE CALL IT WHENEVER REQUIRED
    _savedLogin = savedLogin;

    /// PASSING THE loginSuccessCallback CALLBACK TO THE LOCAL VARIABLE SO THAT WE CAN CALL THAT WHEN THE LOGIN GETS SUCCESS
    _loginSuccessCallback = loginSuccessCallback;

    /// PASSING THE successCallbackScreen CALLBACK TO THE LOCAL VARIABLE SO THAT WE CAN CALL THAT WHEN IT IS REQUIRED
    this.successCallbackScreen = successCallbackScreen;

    userData = (
      loginToken: loginToken != null
          ? LoginToken.fromJson(loginToken.castToMapOfStringDynamic())
          : null,
      userModel: null,
      loginModel: null
    );
  }

  /// LOGIN WITH EMAIL/PHONE
  Future<({LoginModel? loginModel, String? errorMessage})>
      loginWithPhoneEmailViaOTP(
          {required String phoneEmail, bool resendOTP = false}) async {
    try {
      final Map<String, dynamic> requestPayload = {
        "identifier": phoneEmail,
        "lang": getLanguageCode,

        /// RESEND OTP CALL
        if (resendOTP) ...{"forceOTP": true}
      };

      _response = await _httpPost(_loginWithPhoneEmailOTPURL,
          body: requestPayload.castToJsonEncode(), authorization: false);

      final Map<String, dynamic> responseBody =
          _response.body.castToJsonDecodeToMapOfStringDynamic();

      if (_response.statusCode == 200) {
        userData = (
          loginModel: LoginModel.fromJson(responseBody),
          userModel: null,
          loginToken: null,
        );
        setNewUser = userData.loginModel!.userData != null ? false : true;
        return (loginModel: userData.loginModel!, errorMessage: null);
      } else {
        return (
          loginModel: null,
          errorMessage: responseBody["message"].toString()
        );
      }
    } catch (e) {
      "EXCEPTION ON LOGIN WITH PHONE EMAIL OR RESEND OTP API IS $e".toLog();
      return (
        loginModel: null,
        errorMessage: "Something went wrong, please try again!"
      );
    }
  }

  ///REFRESH TOKEN
  Future<void> refreshToken() async {
    try {
      final DateTime validUntil = userData.loginToken!.validUntil.toDateYMDHMS;
      final DateTime today = DateTime.now().toString().toDateYMDHMS;
      if (!today.isBefore(validUntil)) {
        final Map<String, dynamic> requestPayload = {
          "UserData": userData.userModel?.id,
          "refreshToken": userData.loginToken?.refreshToken
        };
        _response = await _httpPost(_refreshTokenURL,
            authorization: false, body: requestPayload.castToJsonEncode());

        final Map<String, dynamic> responseBody =
            _response.body.castToJsonDecodeToMapOfStringDynamic();

        if (_response.statusCode == 200) {
          userData = (
            loginModel: userData.loginModel,
            userModel: userData.userModel,
            loginToken: LoginToken.fromJson(responseBody)
          );

          _savedLogin(userData.loginToken!.toJson());
        }
      }
    } catch (e) {
      "EXCEPTION ON REFRESH TOKEN API IS $e".toLog();
    }
  }

  /// LOGIN WITH OTP
  Future<({UserModel? userModel, String? errorMessage, bool? doubleOtpVerificationEnable})>
  loginWithOtpOrPassword({required String? otp, required String? password, bool twoStepVerification = false, String? twoStepVerificationOTP,})
  async {
    assert(
        (otp != null && password == null) || (otp == null && password != null));

    assert((twoStepVerification == true && twoStepVerificationOTP != null) ||
        (twoStepVerification == false && twoStepVerificationOTP == null));

    try {
      final Map<String, dynamic> requestPayload = {
        "key": userData.loginModel!.key,
        if (otp != null) ...{
          "otp": otp,
        } else ...{
          "password": password,
        },
        if (twoStepVerification) ...{
          "doubleOtpVerification": twoStepVerificationOTP
        }
      };

      _response = await _httpPost(_loginWithOtpOrPasswordURL,
          authorization: false, body: requestPayload.castToJsonEncode());

      final Map<String, dynamic> responseBody =
          _response.body.castToJsonDecodeToMapOfStringDynamic();

      if (_response.statusCode == 200) {
        if (responseBody.containsKey("UserData")) {
          userData = (
            userModel: UserModel.fromJson({
              ...(responseBody["UserData"] as Map).castToMapOfStringDynamic(),
              ...userData.loginModel?.toJson() ?? {}
            }),
            loginModel: userData.loginModel,
            loginToken: LoginToken.fromJson(responseBody)
          );
          _savedLogin(userData.loginToken!.toJson());
        } else if (responseBody.containsKey("state") &&
            responseBody["state"] == "otpVerificationRequired") {
          return (
            userModel: userData.userModel,
            errorMessage: null,
            doubleOtpVerificationEnable: true
          );
        }

        if (_loginSuccessCallback != null) {
          await _loginSuccessCallback!();
          _savedLogin(userData.loginToken!.toJson());
        }

        return (
          userModel: userData.userModel,
          errorMessage: null,
          doubleOtpVerificationEnable: null
        );
      } else {
        return (
          userModel: null,
          errorMessage: responseBody["message"].toString(),
          doubleOtpVerificationEnable: null
        );
      }
    } catch (e) {
      "EXCEPTION ON LOGIN WITH OTP OR PASSWORD API IS $e".toLog();
      return (
        userModel: null,
        errorMessage: "Something went wrong",
        doubleOtpVerificationEnable: null
      );
    }
    return (
      userModel: null,
      errorMessage: null,
      doubleOtpVerificationEnable: null
    );
  }
}

mixin _LoginStateMixin {
  bool isNewUser = true;

  late String _appName;

  String get getAppName => _appName;

  set _setAppName(String appName) => _appName = appName;

  late ValueNotifier<ConnectivityResult?> internetConnectionNotifier;

  late String _languageCode;

  String get getLanguageCode => _languageCode;

  set setLanguageCode(String code) => _languageCode = code;

  set setNewUser(bool value) => isNewUser = value;
}

mixin _HttpExtensions {
  final Map<String, dynamic> _cache = {};

  Future<Response> _httpGet(String url,
      {bool authorization = true,
      Map<String, String>? authorizationObject}) async {
    final Map<String, String> headers = {};

    if (authorization) {
      if (authorizationObject == null) {
        headers.addAll({
          "Authorization":
              "TYRIOS-Token ${loginController.userData.loginToken?.token}"
        });
      } else {
        headers.addAll(authorizationObject);
      }
    }

    try {
      final Response response = await url.toUri().httpGet(headers: headers);
      return _returnResponse(response, url);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> _httpPost(
    String url, {
    required bool authorization,
    Object? body,
    Map<String, String>? authorizationObject,
  }) async {
    final Map<String, String> headers = {};

    if (authorization) {
      if (authorizationObject == null) {
        headers.addAll({
          "Authorization":
              "TYRIOS-Token ${loginController.userData.loginToken?.token}"
        });
      } else {
        headers.addAll(authorizationObject);
      }
    }

    try {
      final Response response =
          await url.toUri().httpPost(body: body, headers: headers);
      return _returnResponse(response, url);
    } catch (e) {
      rethrow;
    }
  }

  Response _returnResponse(Response response, String url) {
    if (response.statusCode >= 500) {
      final Object? response = _getCacheData(url);
      if (response != null) {
        return response as Response;
      }
    }
    if (response.statusCode >= 200) {
      _setCacheData(url, response);
    }
    return response;
  }

  /// CACHE SERVICES
  void _setCacheData(String key, dynamic value) {
    if (_cache.length == 100) {
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = value;
  }

  Object? _getCacheData(String key) => _cacheContains(key) ? _cache[key] : null;

  bool _cacheContains(String key) => _cache.containsKey(key);
}

extension _ApiEndpointsExtension on LoginController {
  String get _refreshTokenURL => "$_baseURL/refreshLogin";

  String get _loginWithPhoneEmailOTPURL => "$_baseURL/otpLogin";

  String get _loginWithOtpOrPasswordURL => "$_baseURL/otpAuthorization";
}
