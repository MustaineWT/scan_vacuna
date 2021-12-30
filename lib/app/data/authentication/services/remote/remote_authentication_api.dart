import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cawaf_api/cawaf_api.dart';
import 'package:vac_card/app/data/authentication/models/user_data_api.dart';
import 'package:vac_card/app/data/data_user/models/response_user_data.dart';
import 'package:vac_card/app/data/data_user/models/user_data.dart';

import '../authentication.dart';

class RemoteAuthenticationApi implements RemoteAuthenticationRepository {
  RemoteAuthenticationApi(this._localAuthenticationRepository);
  final Http __http =
      Http(baseUrl: 'https://hswatcher.com/vacunapp/public/api');

  final LocalAuthenticationRepository _localAuthenticationRepository;

  @override
  Future<StatusResponse> authenticationUser(
    String email,
    String fullname,
    String token,
  ) async {
    HttpResult<LoginResponse> result = await __http.request(
      '/login',
      method: HttpMethod.post,
      body: {
        'email': email,
        'fullname': fullname,
        'token_external': token,
      },
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      parser: (dynamic data) => LoginResponse.fromJson(data),
    );

    if (result.error == null) {
      await _localAuthenticationRepository.clearSession();
      await _localAuthenticationRepository.setSession(result.data!);
      return StatusResponse.success;
    }
    if (result.statusCode == 400) {
      return StatusResponse.accessDenied;
    }
    Object? error = result.error!.exception;
    if (error is SocketException || error is TimeoutException) {
      return StatusResponse.networkError;
    }
    return StatusResponse.unknownError;
  }

  @override
  Future<ResponseRegisterUserData> saveDataUser(
    String tokenQR,
    String token,
    double coordx,
    double coordy,
    UserDataModel userDataModel,
  ) async {
    Map registerUserDataApi;
    registerUserDataApi =
        RegisterUserData.fromReformatData(tokenQR, userDataModel).toJson();
    final response = await __http.request(
      '/save',
      method: HttpMethod.post,
      body: {
        'qr': tokenQR,
        'coordx': coordx.toString(),
        'coordy': coordy.toString(),
        'data': registerUserDataApi['data'].toString(),
      },
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        'Authorization': 'Bearer $token',
        "callMethod": "DOCTOR_AVAILABILITY"
      },
      parser: (dynamic data) => ResponseRegisterUserData.fromJson(data),
    );
    return response.data!;
  }
}
