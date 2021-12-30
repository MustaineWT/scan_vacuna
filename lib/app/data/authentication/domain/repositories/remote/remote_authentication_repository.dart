import 'package:vac_card/app/data/data_user/models/response_user_data.dart';
import 'package:vac_card/app/data/data_user/models/user_data.dart';

import '../../../enum/status_response.dart';

abstract class RemoteAuthenticationRepository {
  Future<StatusResponse> authenticationUser(
    String email,
    String fullname,
    String token,
  );
  Future<ResponseRegisterUserData> saveDataUser(
    String tokenQR,
    String token,
    double coordx,
    double coordy,
    UserDataModel userDataModel,
  );
}
