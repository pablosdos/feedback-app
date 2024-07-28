import 'package:flutter/material.dart';
import '../enums.dart';
import '../pages/pagenotfound.dart';
import '../providers/page_notifier.dart';
import '../routes/routes.dart';
import '../../pages/info_pages/about.dart';

class AppRouterDelegate extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  final PageNotifier notifier;

  AppRouterDelegate({required this.notifier});

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        pages: [
          if (notifier.isUnknown) const MaterialPage(child: PageNotFound()),
          if (!notifier.isUnknown) const MaterialPage(child: PageNotFound()),
          if (notifier.pageName == PageName.home)
            const MaterialPage(child: PageNotFound()),
          if (notifier.pageName == PageName.about)
            const MaterialPage(child: PageNotFound()),
 
        ],
        onPopPage: (route, result) => route.didPop(result));
  }

//currentConfiguration is called whenever there might be a change in route
//It checks for the current page or route and return a new route information
//This is what populates our browser history
  @override
  AppRoute? get currentConfiguration {
    if (notifier.isUnknown) {
      return AppRoute.unknown();
    }

    if (notifier.pageName == PageName.home) {
      return AppRoute.home();
    }

    if (notifier.pageName == PageName.about) {
      return AppRoute.about();
    }



    return AppRoute.unknown();
  }

//This is called whenever the system detects a new route is passed
//It checks the current route through the configuration and uses that to update the notifier
  @override
  Future<void> setNewRoutePath(AppRoute configuration) async {
    if (configuration.isUnknown) {
      _updateRoute(page: null, isUnknown: true);
    }

    if (configuration.isAbout) {
      _updateRoute(page: PageName.about);
    }



    if (configuration.isHome) {
      _updateRoute(page: PageName.home);
    }
  }

  _updateRoute({PageName? page, bool isUnknown = false}) {
    notifier.changePage(page: page, unknown: isUnknown, pageIndex: 4);
  }
}
