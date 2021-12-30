import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'app/core/routes/routemanager.dart';
import 'app/core/utils/context_service.dart';
import 'app/pages/splash/view.dart';
import 'injection_container.dart';

class MyApp extends StatefulWidget {
  const MyApp({required this.banner, Key? key}) : super(key: key);
  final bool banner;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<SplashViewModel>(
          create: (_) => SplashViewModel(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: sl<ContextService>().navigatorKey,
        debugShowCheckedModeBanner: widget.banner,
        title: 'Vacuna Scan',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            splashColor: Colors.white,
            //brightness: Brightness.dark,
            canvasColor: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const SplashPage(),
        onGenerateRoute: RouteManager.generateRoute,
        //initialRoute: RouteManager.initial,
      ),
    );
  }
}
