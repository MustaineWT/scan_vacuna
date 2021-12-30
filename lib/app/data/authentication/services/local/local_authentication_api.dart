import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/local/local_auth_repository.dart';
import '../../enum/session_status.dart';
import '../../models/login_response.dart';

const String keySharedPreferences = 'session';

class LocalAuthenticationApi implements LocalAuthenticationRepository {
  late SharedPreferences _prefs;

  Future<LocalAuthenticationApi> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  @override
  Future<void> clearSession() async {
    await initialize();
    await _prefs.remove(keySharedPreferences);
  }

  @override
  Future<LoginResponse> getSessionData() async {
    await initialize();
    String? data = _prefs.get(keySharedPreferences) as String?;
    LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(data!));
    return loginResponse;
  }

  @override
  Future<SessionStatus> getSession() async {
    await initialize();
    String? data = _prefs.get(keySharedPreferences) as String?;

    if (data != null) {
      LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(data));
      DateTime currentDate = DateTime.now();
      DateTime? createdAt = loginResponse.user!.createdAt;
      int? expiresIn = 31536000;
      int diff = currentDate.difference(createdAt!).inSeconds;
      if (expiresIn - diff >= 30) {
        return SessionStatus.sessionValid;
      } else {
        return SessionStatus.sessionInvalid;
      }
    }
    return SessionStatus.sessionNotFound;
  }

  @override
  Future<LoginResponse> setSession(LoginResponse loginResponse) async {
    await initialize();
    await _prefs.setString(
        keySharedPreferences, jsonEncode(loginResponse.toJson()));
    print(loginResponse.user!.accessToken);
    return loginResponse;
  }
}
