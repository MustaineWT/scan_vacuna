import 'package:flutter/material.dart';

class ContextService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  BuildContext get currentContext => _navigatorKey.currentContext!;
}
