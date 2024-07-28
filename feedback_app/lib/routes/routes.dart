import '../enums.dart';

class AppRoute {
  final PageName? pageName;
  final bool _isUnknown;

  AppRoute.home()
      : pageName = PageName.home,
        _isUnknown = false;



  AppRoute.about()
      : pageName = PageName.about,
        _isUnknown = false;



  AppRoute.unknown()
      : pageName = null,
        _isUnknown = true;

//Used to get the current path
  bool get isHome => pageName == PageName.home;
  bool get isAbout => pageName == PageName.about;

  bool get isUnknown => _isUnknown;
}