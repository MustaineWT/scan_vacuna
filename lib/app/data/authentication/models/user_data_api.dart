import 'package:vac_card/app/data/data_user/models/user_data.dart';

class UserDataApi {
  UserDataApi({
    this.qr,
    this.data,
  });

  String? qr;
  Data? data;

  UserDataApi copyWith({
    String? qr,
    Data? data,
  }) =>
      UserDataApi(
        qr: qr ?? this.qr,
        data: data ?? this.data,
      );

  factory UserDataApi.fromJson(Map<String, dynamic> json) => UserDataApi(
        qr: json["qr"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "qr": qr,
        "data": data!.toJson(),
      };
}

extension RegisterUserData on UserDataApi {
  static UserDataApi fromReformatData(String qr, UserDataModel userDataModel) {
    UserDataModel userDataModelReformat = userDataModel;

    return UserDataApi.fromJson(UserDataApi()
        .copyWith(qr: qr, data: userDataModelReformat.datas)
        .toJson());
  }
}
