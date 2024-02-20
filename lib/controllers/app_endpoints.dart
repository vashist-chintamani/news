part of 'app_controller.dart';

extension _AppEndPoints on AppController {
  String get _baseURL => 'https://www.tyrios.io';

  String get _loginBaseURL => '$_baseURL/service/UserManagement';

  String get _getBlogCategories =>
      '$_baseURL/service/public/ContentManagement/BlogData';

  /// categoryId
  String get _getBlogsFromCategory =>
      '$_baseURL/service/public/ContentManagement/BlogData';

  /// categoryId/blogId
  String get _getBlogDescription =>
      '$_baseURL/service/public/ContentManagement/BlogData';

  String get _getImprintContents =>
      '$_baseURL/service/public/ContentManagement/content/7';

  String get _getPrivacyPolicyContents =>
      '$_baseURL/service/public/ContentManagement/content/9';

  String get _getTermsOfUseContents =>
      '$_baseURL/service/public/ContentManagement/content/236';
}
