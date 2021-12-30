import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vac_card/app/core/utils/context_service.dart';
import 'package:vac_card/app/core/utils/status_notifier.dart';
import 'package:vac_card/app/data/authentication/services/authentication.dart';
import 'package:vac_card/app/pages/home/view.dart';
import 'package:vac_card/injection_container.dart';

class LoginViewModel extends StatusNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  GoogleSignInAccount? userData;
  GoogleSignIn googleSignIn = GoogleSignIn();
  void signOutGoogle() {
    googleSignIn.signOut().then((value) {
      _isLoggedIn = false;
      notifyListeners();
    });
  }

  void signInGoogle() {
    BuildContext context = sl<ContextService>().currentContext;

    googleSignIn.signIn().then((value) async {
      _isLoggedIn = true;
      userData = value;
      if (_isLoggedIn) {
        await sl<RemoteAuthenticationRepository>().authenticationUser(
            userData!.email, userData!.displayName!, 'sintokeninicial');

        await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const HomePage()),
            (Route<dynamic> route) => false);
      }
      notifyListeners();
    });
  }
}
