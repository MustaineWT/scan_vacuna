import 'package:vac_card/app/data/authentication/enum/session_status.dart';
import 'package:vac_card/app/data/authentication/models/login_response.dart';

abstract class LocalAuthenticationRepository {
  Future<void> setSession(LoginResponse loginResponse);
  Future<void> clearSession();
  Future<SessionStatus> getSession();
  Future<LoginResponse> getSessionData();
}
