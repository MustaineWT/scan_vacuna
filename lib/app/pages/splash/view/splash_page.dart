import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vac_card/app/data/authentication/enum/session_status.dart';

import '../../../core/routes/routemanager.dart';
import 'splash_vm.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      Future<Duration?>.delayed(const Duration(milliseconds: 3000), () async {
        SessionStatus isSession =
            await Provider.of<SplashViewModel>(context, listen: false)
                .checkSessionUser();
        switch (isSession) {
          case SessionStatus.sessionLoading:
            break;
          case SessionStatus.sessionValid:
            await Navigator.pushReplacementNamed(context, AppRoutes.home);
            break;
          case SessionStatus.sessionInvalid:
            await Navigator.pushReplacementNamed(context, AppRoutes.login);
            break;
          case SessionStatus.sessionNotFound:
            await Navigator.pushReplacementNamed(context, AppRoutes.login);
            break;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
              )),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Vacuna Scan',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
