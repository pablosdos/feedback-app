import 'package:flutter/material.dart';
import '../enums.dart';

class PageNotifier extends ChangeNotifier {
  PageName? _pageName = PageName.home;
  bool _unknownPath = false;
  int? _currentPageIndex = 0;

  get pageName => _pageName;
  get isUnknown => _unknownPath;
  get currentPageIndex => _currentPageIndex;

  changePage(
      {required PageName? page,
      required bool unknown,
      required int pageIndex}) {
    _pageName = page;
    _unknownPath = unknown;
    _currentPageIndex = pageIndex;
    notifyListeners();
  }
}
