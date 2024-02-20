import 'dart:io';
import 'dart:convert';

import 'package:tyrios_news_app/utilities/common_exports.dart';

part 'app_endpoints.dart';

enum NewsHiveEnum { loginToken, favouriteBlogs, language, isFirstTimeUser }

enum WebNotifierKey { privacy, imprint, termsOfUse, blogDescription }

class AppController with _HttpMixin, _AppStateMixin {
  factory AppController() => _singleton;

  static final AppController _singleton = AppController._internal();

  AppController._internal();

  set setLanguage(String languageCode) {
    _newsBox.put(NewsHiveEnum.language.name, {'languageCode': languageCode});
    categoryBlogs.clear();
    _languageCode = languageCode;
    categoryBlogOffset.clear();
    languageNotifier.value = !languageNotifier.value;

    /// CATEGORY MUST RELOAD SO ALL THE BLOGS INSIDE OF IT WILL RELOAD AUTOMATICALLY
    fetchNewsCategories();
    _setApiNotifiers();
  }

  String get getLanguageCode => _languageCode ?? _context.languageCode;

  void _restoreSelectedAppLanguage() => _languageCode =
      (_newsBox.get(NewsHiveEnum.language.name) as Map?)?['languageCode']
          as String?;

  void sliderCloseDrawer() => sliderDrawerKey.currentState!.closeSideMenu();

  void toggle() {
    final state = sliderDrawerKey.currentState!;
    if (state.isOpened) {
      state.closeSideMenu();
    } else {
      state.openSideMenu();
    }
  }

  void setFavouriteBlog(Blog blog) {
    final Set<int> blogIds = favouriteBlogsFromHive;
    if (blogIds.contains(blog.id)) {
      blogIds.removeWhere((value) => value == blog.id);
      blog.setFavourite = false;
      likeButtonNotifier.value = !likeButtonNotifier.value;
    } else {
      blogIds.add(blog.id);
      blog.setFavourite = true;
      likeButtonNotifier.value = !likeButtonNotifier.value;
    }
    _newsBox.put(
      NewsHiveEnum.favouriteBlogs.name,
      blogIds.toList().toJsonEncode(),
    );
  }

  ///NOTE: CALLING EACH API IN 15 MINUTES OF INTERVAL
  void _notifyFuturesPeriodically() => Timer.periodic(
        const Duration(minutes: 15),
        (timer) => _setApiNotifiers(),
      );

  void _setApiNotifiers() {
    categoryBlogNotifier.value = true;
    notifiers.updateAll((key, value) => true);
  }

  final String _cssStyle = """
<style type="text/css">
        header .author {
            display: grid;
            grid-template-columns: 50px 1fr;
            align-items: center;
            gap: 8px;
            padding: 8px 0;
        }

        header .author .txtBox {
            display: grid;
            padding: 8px 0;
        }

        header .author .txtBox ._name {
            display: inline-block;
            width: 100%;
        }

        header .author .txtBox ._time {
            display: inline-block;
            width: 100%;
            opacity: 0.7;
            font-size: 0.9em;
        }

        header .author .imgBox {
            width: 50px;
            color: red;
            height: 50px;
            border-radius: 50%;
            overflow: hidden;
        }
        
        .letterAvatar {
          align-items: center;
          justify-content:center;
          width: 50px;
          display: flex;
          color: black;
          height: 50px;
          background-color: #F1EBFF;
          border-radius: 50%;
          font-size: 20px;
        }
    </style>""";

  String _titleAndAuthor(
      String title, String authorName, String durationTime, String? imageUrl) {
    String avatarImageTag;
    if (imageUrl != null) {
      avatarImageTag = """
             <picture class="imgBox">
                <img src=$imageUrl class="cover"
                     loading="lazy"
                     alt="Person">
            </picture> """;
    } else {
      avatarImageTag = """
      <div class="letterAvatar">
              ${authorName[0]}
            </div> """;
    }

    return """
      $_cssStyle
  <header class="full-bleed whiteBG">
    <div class="container">
        <div class="txtBox">
            <h2>$title</h2>
        </div>
        <div class="author">
            $avatarImageTag
            <div class="txtBox">
                <span class="_name --ellipsis">$authorName</span>
                <span class="_time --ellipsis">$durationTime</span>
            </div>
        </div>
    </div>
</header>
   """;
  }

  String _htmlTemplate(String header, String body,
          {int topBottomPadding = 0, double leftRightPadding = 0}) =>
      '<html><head>$header</head><body><div class="bodySection" style="padding: ${topBottomPadding}px ${leftRightPadding}px;">$body</div></body></html>';

  String getTYRIOSImageURL(
    TYRIOSImage image, {
    int width = 350,
    int height = 250,
  }) {
    // security layer 1 -> Public URL->  https://domain.com/media/{id}-{encodedFileName}-{width}-{height}-{version}.jpg/wepb/gif/png/mp4/svg
    // https://domain.com/media/{filehash}-{encodedFileName}-{width}-{height}-{version}.jpg/wepb/gif/png/mp4/svg

    if (image.securityLevel == 1) {
      return '$_baseURL/media/${image.id}-${image.encodedFileName}-$width-$height-${image.version}.${image.type.toLowerCase()}';
    }

    return '$_baseURL/media/${image.hash}-${image.encodedFileName}-$width-$height-${image.version}.${image.type.toLowerCase()}';
  }

  int getBlogOffset(int id) {
    if (categoryBlogOffset.containsKey(id)) {
      return categoryBlogOffset[id]!['offset'] as int;
    }
    return 0;
  }

  int getBlogTotalCount(int id) {
    if (categoryBlogOffset.containsKey(id)) {
      return categoryBlogOffset[id]!['totalCount'] as int;
    }
    return 0;
  }

  Future<void> setUpHive() async {
    _newsBox = await Hive.openBox<dynamic>('newsBox');
    if (!_newsBox.containsKey(NewsHiveEnum.favouriteBlogs.name)) {
      unawaited(
        _newsBox.put(
          NewsHiveEnum.favouriteBlogs.name,
          <dynamic>[].toJsonEncode(),
        ),
      );
    }

    if (_newsBox.containsKey(NewsHiveEnum.language.name)) {
      _restoreSelectedAppLanguage();
    }
  }

  List<Blog> get getFavouriteBlogs {
    final List<Blog> favouriteBlogs = [];
    final Set<int> favoriteBlogIds = favouriteBlogsFromHive;

    for (final BlogCategory category in blogData.blogCategories) {
      for (final Blog element in categoryBlogs[category.id] ?? []) {
        for (final int id in favoriteBlogIds.toList()) {
          if (element.id == id) {
            element.setFavourite = true;
            favouriteBlogs.add(element);
          }
        }
      }
    }
    return favouriteBlogs;
  }

  Set<int> get favouriteBlogsFromHive => _newsBox
          .containsKey(NewsHiveEnum.favouriteBlogs.name)
      ? (jsonDecode(_newsBox.get(NewsHiveEnum.favouriteBlogs.name) as String)
              as List<dynamic>)
          .toSet()
          .cast<int>()
      : <int>{};

  Future<void> logout() async {
    await _newsBox.clear();
    categoryBlogs.clear();
    categoryTabIndex.value = 0;
    blogData = (blogCategories: <BlogCategory>[]);
    loginController.userData =
        (loginModel: null, loginToken: null, userModel: null);
    unawaited(
      _newsBox
          .put(NewsHiveEnum.language.name, {'languageCode': getLanguageCode}),
    );
  }

  Future<void> initializeAppResources() async {
    loginController.initialiseLoginPackageResource(
      appName: kAppName,
      context: _context,
      baseUrl: _loginBaseURL,
      languageCode: getLanguageCode,
      successCallbackScreen: const TyriosNewsApp(),
      onboardingWidget: const AppOnboardingScreen(),
      internetConnectionNotifier: internetConnectionState,
      loginToken: _newsBox.get(NewsHiveEnum.loginToken.name) as Map?,
      savedLogin: (Map<dynamic, dynamic> object) =>
          _newsBox.put(NewsHiveEnum.loginToken.name, object),
      loginSuccessCallback: () async {
        categoryBlogs.clear();
        categoryTabIndex.value = 0;
        categoryBlogOffset.clear();
        await _newsBox.clear();
        unawaited(
          _newsBox.put(
            NewsHiveEnum.language.name,
            {'languageCode': getLanguageCode},
          ),
        );
        blogData = (blogCategories: []);
        await fetchNewsCategories();
      },
    );
    await fetchNewsCategories();
    _notifyFuturesPeriodically();
  }

  Future<void> fetchNewsCategories() async {
    try {
      _response = await _httpGet(_getBlogCategories);
      if (_response.statusCode == 200) {
        final List<Map<String, dynamic>> blogs = (_response.body
                .castToJsonDecodeToMapOfStringDynamic()['blogData'] as List)
            .castToListOfMapOfStringDynamic();

        final List<BlogCategory> categories =
            blogs.map(BlogCategory.fromJson).toList();

        blogData = (blogCategories: categories);
      } else {}
    } on Exception catch (e) {
      'EXCEPTION ON FETCH_NEWS_CATEGORIES IS $e'.toLog();
    }
  }

  Future<void> fetchBlogsFromCategory(
    int categoryId, {
    bool isInfiniteScroll = false,
  }) async {
    try {
      _response = await _httpGet(
        isInfiniteScroll
            ? '$_getBlogsFromCategory/$categoryId?offset=${getBlogOffset(categoryId)}&length=10'
            : '$_getBlogsFromCategory/$categoryId?offset=0&length=10',
      );

      if (_response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            _response.body.castToJsonDecodeToMapOfStringDynamic();

        final List<Map<String, dynamic>> blogs =
            (responseBody['blogEntryData'] as List)
                .castToListOfMapOfStringDynamic();

        categoryBlogOffset.putIfAbsent(
          categoryId,
          () => {
            'offset': 10,
            'totalCount': responseBody['count'].toString().toInt(),
          },
        );

        if (isInfiniteScroll) {
          categoryBlogOffset.update(
            categoryId,
            (value) {
              final int offset = value['offset'] as int;
              final int count = responseBody['count'].toString().toInt();

              /// TERMINATING THE FLOW OF INFINITE SCROLL ONCE THE BLOGS API RESPONSE IS EMPTY
              if (blogs.isEmpty) {
                /// PUTTING THE OFFSET TO TOTAL COUNT OF THE BLOGS SO TO STOP THE NEXT API CALL
                return {
                  'offset': count,
                  'totalCount': count,
                };
              }

              return {
                'offset': offset + 10,
                'totalCount': count,
              };
            },
            ifAbsent: () => {
              'offset': 10,
              'totalCount': responseBody['count'].toString().toInt(),
            },
          );
        }

        final List<Blog> newBlogs = blogs.map((e) {
          final Blog blog = Blog(
            categoryId: categoryId,
            link: e['link'] as String?,
            title: e['title'] as String,
            id: e['id'].toString().toInt(),
            readingTime: e['readingTime'] as int?,
            teaserText: e['teaserText'] as String?,
            author: Author.fromJson(e['author'] as Map<String, dynamic>),
            teaserImage: e['teaserImage'] != null
                ? TYRIOSImage.fromJson(e['teaserImage'] as Map<String, dynamic>)
                : null,
          );
          if (favouriteBlogsFromHive.contains(blog.id)) {
            blog.setFavourite = true;
            likeButtonNotifier.value = !likeButtonNotifier.value;
          }
          return blog;
        }).toList();

        categoryBlogs[categoryId] =
            {...?categoryBlogs[categoryId], ...newBlogs}.toList();
      }
    } on Exception catch (e) {
      'EXCEPTION ON FETCH_BLOG_FROM_CATEGORIES IS $e'.toLog();
    } finally {
      pullToRefreshToFetchCategoryBlogs.value = false;
      categoryBlogNotifier.value = false;
      notifiers.update('categoryBlogCallFuture', (_) => false);
    }
  }

  Future<Blog?> fetchBlogDescription(int categoryId, int blogId) async {
    try {
      final List<Blog> blogList = categoryBlogs[categoryId] ?? [];
      final int index = blogList.indexWhere((element) => element.id == blogId);

      if (index >= 0 && blogList[index].content == null) {
        _response = await _httpGet('$_getBlogDescription/$categoryId/$blogId');

        if (_response.statusCode == 200) {
          final Map<String, dynamic> data = _response.body
              .castToJsonDecodeToMapOfStringDynamic()
            ..putIfAbsent('categoryId', () => categoryId);

          final Blog blog = blogList
              .singleWhere((element) => element.id == blogId)
              .copyWith(data);

          blogList[index] = blog;

          categoryBlogs[categoryId] = blogList;

          final Blog newBlog =
              blogList.firstWhere((element) => element.id == blog.id);

          final String htmlHeader =
              parse(newBlog.content?.htmlHeader).outerHtml;

          final String htmlBody = parse(newBlog.content?.html).outerHtml;

          final WebViewController webViewController =
              await buildWebViewController(
            HtmlContent(
              null,
              htmlHeader,
              htmlBody,
            ),
            WebNotifierKey.blogDescription,
            newBlog,
          );

          newBlog.setWebViewContent = webViewController;

          return newBlog;
        } else {}
      } else {
        return blogList[index];
      }
    } on Exception catch (e) {
      'EXCEPTION ON FETCH_BLOG_DESCRIPTION IS $e'.toLog();
    }
    return null;
  }

  Future<WebViewController?> fetchAppPolicyContents({
    bool imprint = false,
    bool termsOfUse = false,
    bool privacyPolicy = false,
  }) async {
    try {
      final Map<String, WebNotifierKey> urlWithNotifierKey = imprint
          ? {_getImprintContents: WebNotifierKey.imprint}
          : termsOfUse
              ? {_getTermsOfUseContents: WebNotifierKey.termsOfUse}
              : {_getPrivacyPolicyContents: WebNotifierKey.privacy};

      _response = await _httpGet(urlWithNotifierKey.keys.first);

      if (_response.statusCode == 200) {
        final Map<String, dynamic> data =
            _response.body.castToJsonDecodeToMapOfStringDynamic();

        final HtmlContent htmlContent =
            HtmlContent.fromJson(data['content'] as Map<String, dynamic>);

        return await buildWebViewController(
          htmlContent,
          urlWithNotifierKey.values.first,
        );
      }
    } on Exception catch (e) {
      'EXCEPTION ON FETCH ${_response.request?.url},CONTENTS IS $e'.toLog();
    }
    return null;
  }

  Future<WebViewController> buildWebViewController(
      HtmlContent htmlContent, WebNotifierKey webNotifierKey,
      [Blog? blog]) async {
    webViewNotifiers[webNotifierKey]!.value = true;
    WebViewController webViewController = WebViewController();
    webViewController = webViewController
      ..setBackgroundColor(
        _context.mounted
            ? _context.scaffoldBackgroundColor
            : Colors.transparent,
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'ARTICLE_SCROLL_CHANNEL',
        onMessageReceived: (progress) {
          final double currentPosition = double.parse(progress.message) / 100;

          if (currentPosition == blogDescriptionWebScrollPosition) {
            /// DON'T NOTIFY
            /// NOTHING TO DO
          } else {
            if (currentPosition <= 0.0 || currentPosition > 1.0) {
              return;
            }

            if (currentPosition > blogDescriptionWebScrollPosition) {
              /// NOTIFYING TO SHOW THE APP BAR

              blogDescriptionWebScrollPositionNotifier.value = false;
            } else {
              /// NOTIFYING TO NOT TO SHOW THE APP BAR
              blogDescriptionWebScrollPositionNotifier.value = true;
            }

            /// DATA UPDATE HERE
            blogDescriptionWebScrollPosition = currentPosition;
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            if (webViewNotifiers.containsKey(webNotifierKey)) {
              webViewNotifiers[webNotifierKey]!.value = false;
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onPageFinished: (String url) {
            webViewController.runJavaScript(
              '''
              window.addEventListener('scroll', function() {
                progress = (this.scrollY / ( document.body.scrollHeight - window.innerHeight ) ) * 100;
                window.ARTICLE_SCROLL_CHANNEL.postMessage(progress);
              });
              ''',
            );
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('tel:')) {
              request.url.toUri().launchPhoneURL();
              return NavigationDecision.prevent;
            }

            if (request.url.contains('mailto:')) {
              request.url.toUri().launchEmailURL();
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith('https:')) {
              request.url.toUri().launchURL();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    if (blog != null) {
      String? authorImageUrl;
      if (blog.author != null) {
        if (blog.author!.image != null) {
          authorImageUrl = getTYRIOSImageURL(
            blog.author!.image!,
            width: 150,
            height: 100,
          );
        }
      }

      final String titleAndAuthorHtml = _titleAndAuthor(
          blog.title,
          blog.author!.getFullName,
          "${Duration(seconds: blog.readingTime!).inMinutes} ${strings.minRead}",
          authorImageUrl);

      await webViewController.loadHtmlString(
        _htmlTemplate(titleAndAuthorHtml + (htmlContent.htmlHeader ?? ""),
            htmlContent.html),
      );
    } else {
      await webViewController.loadHtmlString(
        _htmlTemplate(htmlContent.htmlHeader ?? "", htmlContent.html,
            topBottomPadding: 16),
      );
    }

    return webViewController;
  }

  /// TODO: NEED TO WRITE THE MINIMAL CODE HERE AND CODE REFACTOR REQUIRED
  Future<void> shareBlog(Blog blog) async {
    try {
      if (blog.teaserImage != null) {
        _response = await _httpGet(getTYRIOSImageURL(blog.teaserImage!));

        final Directory documentDirectory =
            await getApplicationDocumentsDirectory();

        final File file = File(
          "${documentDirectory.path}/${blog.title}.${blog.teaserImage?.type ?? ".png"}",
        )..writeAsBytesSync(_response.bodyBytes);

        if (_context.mounted) {
          /// SHARE BLOG NAME AND IMAGE
          await Share.shareXFiles(
            [
              XFile(
                file.path,
                name: '${blog.title}.${blog.teaserImage?.type ?? "png"}',
              ),
            ],
            subject: blog.title,
            text: blog.link != null ? blog.link! : blog.teaserText,
            sharePositionOrigin: Rect.fromLTWH(
              0,
              0,
              _context.screenWidth,
              _context.screenHeight / 2,
            ),
          );
        }
      } else {
        await Share.share(
          blog.link != null ? blog.link! : blog.teaserText ?? '',
          subject: blog.title,
          sharePositionOrigin: Rect.fromLTWH(
            0,
            0,
            _context.screenWidth,
            _context.screenHeight / 2,
          ),
        );
      }
    } on Exception catch (e) {
      'EXCEPTION ON SHARE BLOG FUNCTION IS $e'.toLog();
    }
  }
}

mixin _AppStateMixin {
  BuildContext? ctx;

  set setContext(BuildContext context) => ctx = context;

  BuildContext get _context => ctx ?? NavigationServices.context;

  ValueNotifier<ConnectivityResult?> internetConnectionState =
      ValueNotifier(null);

  late Box<dynamic> _newsBox;

  bool get isFirstTimeUser =>
      _newsBox.get(NewsHiveEnum.isFirstTimeUser.name, defaultValue: true)
          as bool;

  set setFirstTimeUserFlagToHive(bool value) {
    _newsBox.put(NewsHiveEnum.isFirstTimeUser.name, value);
  }

  final Map<int, Map<String, dynamic>> categoryBlogOffset = {};

  double blogDescriptionWebScrollPosition = 0;

  final ValueNotifier<bool> blogDescriptionWebScrollPositionNotifier =
      ValueNotifier(true);

  final ValueNotifier<int> categoryTabIndex = ValueNotifier(0);

  final ValueNotifier<int> selectedDrawerTabNotifier = ValueNotifier(0);

  final ValueNotifier<bool> likeButtonNotifier = ValueNotifier(false);

  int totalBlogCount = 0;

  String? _languageCode;

  final Map<WebNotifierKey, ValueNotifier<bool>> webViewNotifiers =
      <WebNotifierKey, ValueNotifier<bool>>{
    for (var webNotifier in WebNotifierKey.values)
      webNotifier: ValueNotifier(true),
  };

  ({List<BlogCategory> blogCategories}) blogData =
      (blogCategories: <BlogCategory>[]);

  final ValueNotifier<bool> languageNotifier = ValueNotifier(false);

  final Set<String> appLanguages = {'en', 'de'};

  final ValueNotifier<bool> pullToRefreshToFetchCategoryBlogs =
      ValueNotifier(true);
  final ValueNotifier<bool> categoryBlogNotifier = ValueNotifier(false);

  final Map<String, dynamic> notifiers = {'categoryBlogCallFuture': false};

  final Map<int, List<Blog>> categoryBlogs = {};

  final ValueNotifier<bool> notifyCategoryBlog = ValueNotifier(false);

  late Response _response;

  final ValueNotifier<int> appNavIndex = ValueNotifier(0);

  ({ValueNotifier<Size> landscape, ValueNotifier<Size> portrait}) tabletHeight =
      (landscape: ValueNotifier(Size.zero), portrait: ValueNotifier(Size.zero));

  late GlobalKey<SideMenuState> sliderDrawerKey;
}

mixin _HttpMixin {
  final Map<String, dynamic> _cache = {};

  Future<Response> _httpGet(
    String url, {
    bool authorization = true,
    Map<String, String>? authorizationObject,
  }) async {
    final Map<String, String> headers = {
      'Accept-Language': appController.getLanguageCode,
    };

    if (authorization) {
      if (authorizationObject == null) {
        headers.addAll({
          'Authorization':
              'TYRIOS-Token ${loginController.userData.loginToken?.token}',
        });
      } else {
        headers.addAll(authorizationObject);
      }
    }

    try {
      final Response response = await url.toUri().httpGet(headers: headers);
      return _returnResponse(response, url);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Response> _httpPost(
    String url, {
    bool authorization = true,
    Object? body,
    Map<String, String>? authorizationObject,
  }) async {
    final Map<String, String> headers = {
      'Accept-Language': appController.getLanguageCode,
    };

    if (authorization) {
      if (authorizationObject == null) {
        headers.addAll({
          'Authorization':
              'TYRIOS-Token ${loginController.userData.loginToken?.token}',
        });
      } else {
        headers.addAll(authorizationObject);
      }
    }

    try {
      final Response response =
          await url.toUri().httpPost(body: body, headers: headers);
      return _returnResponse(response, url);
    } on Exception catch (_) {
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
