import 'package:vac_card/app/core/utils/status_notifier.dart';
import 'package:vac_card/app/data/authentication/services/authentication.dart';
import 'package:vac_card/injection_container.dart';

class HomeViewModel extends StatusNotifier {
  HomeViewModel() {
    initUserData();
  }
  String? _name;
  String? _email;
  String? get name => _name;
  String? get email => _email;
  LoginResponse? _loginResponse;

  void initUserData() async {
    _loginResponse = await sl<LocalAuthenticationRepository>().getSessionData();
    _name = _loginResponse?.user!.name;
    _email = _loginResponse?.user!.email;
    notifyListeners();
  }

  void logOff() async {
    await sl<LocalAuthenticationRepository>().clearSession();
  }
}
