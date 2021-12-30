import 'package:vac_card/app/data/authentication/services/authentication.dart';
import 'package:vac_card/injection_container.dart';
import '../../../core/utils/status_notifier.dart';

class SplashViewModel extends StatusNotifier {
  SplashViewModel() {
    checkSessionUser();
  }

  Future<SessionStatus> checkSessionUser() async {
    SessionStatus isSession =
        await sl<LocalAuthenticationRepository>().getSession();
    return isSession;
  }
}
