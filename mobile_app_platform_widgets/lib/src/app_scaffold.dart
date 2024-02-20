import 'package:mobile_app_platform_widgets/common_exports.dart';

class AppScaffold extends StatelessWidget {
  final Widget? body;
  final dynamic title;
  final Widget? drawer;
  final Widget? middle;
  final Border? border;
  final Widget? leading;
  final Widget? trailing;
  final ShapeBorder? shape;
  final bool showBackButton;
  final List<Widget>? actions;
  final List<Widget>? slivers;
  final bool disableScrollbar;
  final Color? backgroundColor;
  final ScrollPhysics? physics;
  final String? previousPageTitle;
  final Widget? customSliverAppBar;
  final PreferredSizeWidget? bottom;
  final Widget? bottomNavigationBar;
  final bool showMiddleWidgetAlways;
  final List<Widget>? headerSlivers;
  final Color? appBarBackgroundColor;
  final Widget? floatingActionButton;
  final VoidCallback? backButtonCallback;
  final ScrollController? scrollController;
  final Color? appForegroundBackgroundColor;
  final AsyncCallback? pullToRefreshCallback;
  final ValueNotifier<bool>? showAppBarNotifier;
  final Alignment floatingActionButtonAlignment;
  final ScrollController? nestedScrollController;
  final CupertinoTabScaffold? cupertinoTabScaffold;
  final ValueSetter<ScrollNotification>? scrollEndNotificationCallback;

  const AppScaffold({
    super.key,
    this.title,
    this.body,
    this.shape,
    this.drawer,
    this.border,
    this.bottom,
    this.middle,
    this.leading,
    this.slivers,
    this.actions,
    this.physics,
    this.trailing,
    this.headerSlivers,
    this.backgroundColor,
    this.scrollController,
    this.showAppBarNotifier,
    this.previousPageTitle,
    this.customSliverAppBar,
    this.backButtonCallback,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.cupertinoTabScaffold,
    this.appBarBackgroundColor,
    this.pullToRefreshCallback,
    this.showBackButton = true,
    this.nestedScrollController,
    this.disableScrollbar = false,
    this.appForegroundBackgroundColor,
    this.scrollEndNotificationCallback,
    this.showMiddleWidgetAlways = false,
    this.floatingActionButtonAlignment = Alignment.center,
  }) : assert(
            (body != null && slivers == null) ||
                (slivers != null && body == null),
            'Body and Slivers both can not be add at the same time');

  @override
  Widget build(BuildContext context) {
    if (context.isIOS) {
      return Material(
        child: Stack(
          children: [
            cupertinoTabScaffold ??
                CupertinoPageScaffold(
                  backgroundColor:
                      backgroundColor ?? context.scaffoldBackgroundColor,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: showAppBarNotifier ?? ValueNotifier(true),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollStartNotification) {
                        } else if (scrollNotification
                            is ScrollEndNotification) {
                          if (scrollEndNotificationCallback != null) {
                            scrollEndNotificationCallback!(scrollNotification);
                          }
                        } else if (scrollNotification
                            is ScrollUpdateNotification) {}
                        return false;
                      },
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: AppScrollbar(
                          controller: scrollController,
                          disableScrollbar: disableScrollbar,
                          child: CustomScrollView(
                            physics: physics,
                            controller: scrollController,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            slivers: [
                              if (pullToRefreshCallback != null) ...{
                                CupertinoSliverRefreshControl(
                                    onRefresh: pullToRefreshCallback),
                              },
                              if (body != null) ...{
                                SliverFillRemaining(child: body!)
                              },
                              ...?slivers,
                            ],
                          ),
                        ),
                      ),
                    ),
                    builder: (context, showAppbar, child) => NestedScrollView(
                      physics: physics,
                      controller: nestedScrollController,
                      headerSliverBuilder: (context, bool isInnerBoxScrolled) {
                        return [
                          if (showAppbar) ...{
                            customSliverAppBar ??
                                CupertinoSliverNavigationBar(
                                  middle: middle,
                                  backgroundColor: appBarBackgroundColor,
                                  alwaysShowMiddle: showMiddleWidgetAlways,
                                  automaticallyImplyLeading: showBackButton,
                                  trailing: trailing,
                                  border: border ??
                                      const Border(
                                        bottom: BorderSide(
                                          color: Color(0x4D000000),
                                          width:
                                              0.0, // 0.0 means one physical pixel
                                        ),
                                      ),
                                  largeTitle: title is Widget
                                      ? title as Widget?
                                      : Text(
                                          title?.toString() ?? "",
                                          style: TextStyle(
                                            color: context.primaryColorDark,
                                          ),
                                        ),
                                  leading: leading ??
                                      (showBackButton
                                          ? context.isAndroid
                                              ? IconButton(
                                                  onPressed: context.pop,
                                                  icon: Icon(
                                                    CupertinoIcons.back,
                                                    color: context
                                                        .primaryColorDark,
                                                  ),
                                                )
                                              : Container(
                                                  transform:
                                                      Matrix4.translationValues(
                                                          -12, 2, 0),
                                                  child:
                                                      CupertinoNavigationBarBackButton(
                                                    onPressed:
                                                        backButtonCallback ??
                                                            context.pop,
                                                    color: context
                                                        .primaryColorDark,
                                                    previousPageTitle:
                                                        previousPageTitle ??
                                                            "Back",
                                                  ),
                                                )
                                          : null),
                                ),
                          },
                          ...?headerSlivers,
                        ];
                      },
                      body: child!,
                    ),
                  ),
                ),
            if (floatingActionButton != null) ...[
              Positioned(
                child: Align(
                  alignment: floatingActionButtonAlignment,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: floatingActionButton!,
                  ),
                ),
              )
            ]
          ],
        ),
      );
    } else {
      return Scaffold(
        drawer: drawer,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        body: RefreshIndicator(
          onRefresh: () async {
            if (pullToRefreshCallback != null) {
              pullToRefreshCallback!();
            }
          },
          child: AppScrollbar(
            controller: scrollController,
            disableScrollbar: disableScrollbar,
            child: CustomScrollView(
              controller: scrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                customSliverAppBar ??
                    SliverAppBar(
                      snap: true,
                      pinned: true,
                      floating: true,
                      bottom: bottom,
                      actions: actions,
                      centerTitle: true,
                      expandedHeight: 104,
                      automaticallyImplyLeading: showBackButton,
                      backgroundColor:
                          appBarBackgroundColor ?? Colors.transparent,
                      foregroundColor: appForegroundBackgroundColor ??
                          (context.isDarkMode
                              ? const Color(0xFF202124)
                              : Colors.white),
                      leading: leading ??
                          (showBackButton
                              ? IconButton(
                                  icon: const Icon(Icons.arrow_back_outlined),
                                  onPressed: backButtonCallback ?? context.pop,
                                  color: context.isDarkMode
                                      ? context.primaryColor
                                      : context.secondaryColor,
                                )
                              : null),
                      flexibleSpace: FlexibleSpaceBar(
                        // centerTitle: true,
                        expandedTitleScale: 1.2,
                        background: ColoredBox(
                            color: context.isDarkMode
                                ? const Color(0xFF202124)
                                : Colors.white),
                        // titlePadding: const EdgeInsets.only(left: 16, bottom: 12),
                        title: title is Widget?
                            ? title as Widget?
                            : Text(
                                title.toString(),
                                style: TextStyle(
                                    color: context.isDarkMode
                                        ? context.primaryColor
                                        : context.secondaryColor,
                                    fontSize: 24),
                              ),
                      ),
                    ),
                if (body != null) ...{SliverToBoxAdapter(child: body!)},
                ...?slivers,
              ],
            ),
          ),
        ),
      );
    }
  }
}
