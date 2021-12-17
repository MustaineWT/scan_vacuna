import 'package:flutter/material.dart';

import 'app.dart';
import 'app/core/utils/enviroments.dart';
import 'injection_container.dart' as di;

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  bool? banner;
  switch (env) {
    case Environment.dev:
      banner = true;
      break;
    case Environment.prod:
      banner = false;
      break;
  }

  runApp(
    MyApp(banner: banner!),
  );
}
