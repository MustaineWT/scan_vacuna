import 'dart:async';

import 'package:cawaf_api/cawaf_api.dart';
import 'package:vac_card/app/data/data_user/domain/repositories/remote/remote_data_user_repository.dart';
import 'package:vac_card/app/data/data_user/models/user_data.dart';

class RemoteDataUserApi implements RemoteDataUserRepository {
  RemoteDataUserApi(this._http);
  final Http _http;

  @override
  Future<UserDataModel?> getDataUser(
    String token,
  ) async {
    HttpResult<UserDataModel> response = await _http
        .request(
          '/data-qr',
          method: HttpMethod.post,
          body: {
            'Id': token,
          },
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer $token",
          },
          parser: (dynamic data) => UserDataModel.fromJson(data),
        )
        .timeout(Duration(seconds: 10));
    return response.data;
  }
}
