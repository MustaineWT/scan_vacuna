import 'package:vac_card/app/core/utils/status_notifier.dart';
import 'package:vac_card/app/data/data_user/data_user.dart';
import 'package:vac_card/app/data/data_user/models/user_data.dart';
import 'package:vac_card/injection_container.dart';

class HomeViewModel extends StatusNotifier {
  UserDataModel? userDataModel;
  Future<UserDataModel> formatDataResponse(String? scanData) async {
    String? texto = scanData?.substring(scanData.indexOf('Tk=') + 3);
    userDataModel = await sl<RemoteDataUserRepository>().getDataUser(texto!);
    return userDataModel!;
  }
}
