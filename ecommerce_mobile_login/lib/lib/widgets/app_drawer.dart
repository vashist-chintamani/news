import 'package:tyrios_news_app/utilities/common_exports.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: context.primaryColor.withOpacity(0.32)),
            ),
          ),
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 16, 8, 8),
                  child: Text(
                    kAppName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Divider(),
                Flexible(
                  child: SingleChildScrollView(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        final List<String> drawerOptions = [
                          strings.home,
                          if (loginController.userData.loginToken != null) ...{
                            strings.logout,
                          } else ...{
                            strings.login,
                          },
                          strings.imprint,
                          strings.privacyPolicy,
                          strings.termsOfUse,
                          strings.theme,
                          strings.language,
                          strings.settings,
                          strings.deleteAccount,
                        ];
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: drawerOptions.length,
                          padding: const EdgeInsets.all(8),
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              const Visibility(
                            visible: false,
                            child: SizedBox(
                              height: 0,
                              child: Divider(
                                height: 20,
                                indent: 18,
                                endIndent: 8,
                                thickness: 0.5,
                              ),
                            ),
                          ),
                          itemBuilder: (context, index) {
                            final String drawerOption = drawerOptions[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 4),
                              child: ListTile(
                                title: Text(drawerOption),
                                visualDensity:
                                    const VisualDensity(vertical: -4),
                                selected: appController
                                        .selectedDrawerTabNotifier.value ==
                                    index,
                                onTap: () async {
                                  if (drawerOption == strings.login) {
                                    unawaited(context.pushNamed(Routes.login));
                                    appController
                                        .selectedDrawerTabNotifier.value = 0;
                                    appController.toggle();
                                  } else if (drawerOption == strings.theme) {
                                    unawaited(
                                      context.showAppGeneralDialog(
                                        barrierColor: context.isDarkMode
                                            ? Colors.black.withOpacity(0.2)
                                            : Colors.black.withOpacity(0.4),
                                        child: const SizedBox.shrink(),
                                      ),
                                    );
                                    context.setAppTheme((themeMode) =>
                                        Hive.box<dynamic>('appTheme').put(
                                            'themeValue',
                                            (appThemeMode.value = themeMode)
                                                .name));
                                    appController.toggle();
                                    unawaited(
                                      Future<dynamic>.delayed(
                                        const Duration(milliseconds: 500),
                                      ).whenComplete(context.pop),
                                    );
                                  } else if (drawerOption == strings.logout) {
                                    unawaited(
                                      context.showAppGeneralDialog(
                                        child: const Center(child: AppLoader()),
                                      ),
                                    );
                                    unawaited(
                                      appController.logout().whenComplete(
                                            () => appController
                                                .fetchNewsCategories()
                                                .whenComplete(
                                                  () => context
                                                      .pushNamedAndRemoveUntil(
                                                    Routes.home,
                                                  ),
                                                ),
                                          ),
                                    );
                                  } else if (drawerOption ==
                                      strings.deleteAccount) {
                                    return showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text(strings.deleteAccount),
                                          content: Text(
                                            strings.warningMessage,
                                          ),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              child: Text(strings.cancelText),
                                              onPressed: () {
                                                context.pop();
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              isDestructiveAction: true,
                                              onPressed: () {
                                                context.pop();
                                              },
                                              child: Text(strings.delete),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    setState(
                                      () => appController
                                        ..selectedDrawerTabNotifier.value =
                                            index
                                        ..toggle(),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
