class UserDataModel {
  UserDataModel({
    this.responsetId,
    this.messageId,
    this.actions,
    this.state,
    this.isNew,
    this.success,
    this.datas,
  });

  int? responsetId;
  int? messageId;
  String? actions;
  String? state;
  bool? isNew;
  bool? success;
  Data? datas;

  UserDataModel copyWith({
    int? responsetId,
    int? messageId,
    String? actions,
    String? state,
    bool? isNew,
    bool? success,
    Data? datas,
  }) =>
      UserDataModel(
        responsetId: responsetId ?? this.responsetId,
        messageId: messageId ?? this.messageId,
        actions: actions ?? this.actions,
        state: state ?? this.state,
        isNew: isNew ?? this.isNew,
        success: success ?? this.success,
        datas: datas ?? this.datas,
      );

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        responsetId: json["ResponsetId"],
        messageId: json["MessageId"],
        actions: json["Actions"],
        state: json["State"],
        isNew: json["IsNew"],
        success: json["Success"],
        datas: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "ResponsetId": responsetId,
        "MessageId": messageId,
        "Actions": actions,
        "State": state,
        "IsNew": isNew,
        "Success": success,
        "Data": datas!.toJson(),
      };
}

class Data {
  Data({
    this.fecConsulta,
    this.fecGenerada,
    this.fecExpira,
    this.idPersona,
    this.nombres,
    this.apelPaterno,
    this.apelMaterno,
    this.fechNacimiento,
    this.idGenero,
    this.numDoc,
    this.idTipoDoc,
    this.descTipoDoc,
    this.idPais,
    this.descPais,
    this.vacunaDosisAplico,
    this.vacunas,
  });

  String? fecConsulta;
  String? fecGenerada;
  String? fecExpira;
  int? idPersona;
  String? nombres;
  String? apelPaterno;
  String? apelMaterno;
  String? fechNacimiento;
  String? idGenero;
  String? numDoc;
  int? idTipoDoc;
  String? descTipoDoc;
  String? idPais;
  String? descPais;
  String? vacunaDosisAplico;
  List<Vacuna>? vacunas;

  Data copyWith({
    String? fecConsulta,
    String? fecGenerada,
    String? fecExpira,
    int? idPersona,
    String? nombres,
    String? apelPaterno,
    String? apelMaterno,
    String? fechNacimiento,
    String? idGenero,
    String? numDoc,
    int? idTipoDoc,
    String? descTipoDoc,
    String? idPais,
    String? descPais,
    String? vacunaDosisAplico,
    List<Vacuna>? vacunas,
  }) =>
      Data(
        fecConsulta: fecConsulta ?? this.fecConsulta,
        fecGenerada: fecGenerada ?? this.fecGenerada,
        fecExpira: fecExpira ?? this.fecExpira,
        idPersona: idPersona ?? this.idPersona,
        nombres: nombres ?? this.nombres,
        apelPaterno: apelPaterno ?? this.apelPaterno,
        apelMaterno: apelMaterno ?? this.apelMaterno,
        fechNacimiento: fechNacimiento ?? this.fechNacimiento,
        idGenero: idGenero ?? this.idGenero,
        numDoc: numDoc ?? this.numDoc,
        idTipoDoc: idTipoDoc ?? this.idTipoDoc,
        descTipoDoc: descTipoDoc ?? this.descTipoDoc,
        idPais: idPais ?? this.idPais,
        descPais: descPais ?? this.descPais,
        vacunaDosisAplico: vacunaDosisAplico ?? this.vacunaDosisAplico,
        vacunas: vacunas ?? this.vacunas,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fecConsulta: json["FecConsulta"],
        fecGenerada: json["FecGenerada"],
        fecExpira: json["FecExpira"],
        idPersona: json["IdPersona"],
        nombres: json["Nombres"],
        apelPaterno: json["ApelPaterno"],
        apelMaterno: json["ApelMaterno"],
        fechNacimiento: json["FechNacimiento"],
        idGenero: json["IdGenero"],
        numDoc: json["NumDoc"],
        idTipoDoc: json["IdTipoDoc"],
        descTipoDoc: json["DescTipoDoc"],
        idPais: json["IdPais"],
        descPais: json["DescPais"],
        vacunaDosisAplico: json["VacunaDosisAplico"],
        vacunas:
            List<Vacuna>.from(json["Vacunas"].map((x) => Vacuna.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "FecConsulta": fecConsulta,
        "FecGenerada": fecGenerada,
        "FecExpira": fecExpira,
        "IdPersona": idPersona,
        "Nombres": nombres,
        "ApelPaterno": apelPaterno,
        "ApelMaterno": apelMaterno,
        "FechNacimiento": fechNacimiento,
        "IdGenero": idGenero,
        "NumDoc": numDoc,
        "IdTipoDoc": idTipoDoc,
        "DescTipoDoc": descTipoDoc,
        "IdPais": idPais,
        "DescPais": descPais,
        "VacunaDosisAplico": vacunaDosisAplico,
        "Vacunas": List<dynamic>.from(vacunas!.map((x) => x.toJson())),
      };
}

class Vacuna {
  Vacuna({
    this.idVacuna,
    this.descCodigo,
    this.descVacuna,
    this.idDosis,
    this.nroDosis,
    this.descDosis,
    this.vacunaLote,
    this.vacunaFabricante,
    this.idEstablecimiento,
    this.codunico,
    this.estNombre,
    this.vacunaFecha,
  });

  int? idVacuna;
  String? descCodigo;
  String? descVacuna;
  String? idDosis;
  String? nroDosis;
  String? descDosis;
  String? vacunaLote;
  String? vacunaFabricante;
  int? idEstablecimiento;
  int? codunico;
  String? estNombre;
  String? vacunaFecha;

  Vacuna copyWith({
    int? idVacuna,
    String? descCodigo,
    String? descVacuna,
    String? idDosis,
    String? nroDosis,
    String? descDosis,
    String? vacunaLote,
    String? vacunaFabricante,
    int? idEstablecimiento,
    int? codunico,
    String? estNombre,
    String? vacunaFecha,
  }) =>
      Vacuna(
        idVacuna: idVacuna ?? this.idVacuna,
        descCodigo: descCodigo ?? this.descCodigo,
        descVacuna: descVacuna ?? this.descVacuna,
        idDosis: idDosis ?? this.idDosis,
        nroDosis: nroDosis ?? this.nroDosis,
        descDosis: descDosis ?? this.descDosis,
        vacunaLote: vacunaLote ?? this.vacunaLote,
        vacunaFabricante: vacunaFabricante ?? this.vacunaFabricante,
        idEstablecimiento: idEstablecimiento ?? this.idEstablecimiento,
        codunico: codunico ?? this.codunico,
        estNombre: estNombre ?? this.estNombre,
        vacunaFecha: vacunaFecha ?? this.vacunaFecha,
      );

  factory Vacuna.fromJson(Map<String, dynamic> json) => Vacuna(
        idVacuna: json["IdVacuna"],
        descCodigo: json["DescCodigo"],
        descVacuna: json["DescVacuna"],
        idDosis: json["IdDosis"],
        nroDosis: json["NroDosis"],
        descDosis: json["DescDosis"],
        vacunaLote: json["VacunaLote"],
        vacunaFabricante: json["VacunaFabricante"],
        idEstablecimiento: json["IdEstablecimiento"],
        codunico: json["Codunico"],
        estNombre: json["EstNombre"],
        vacunaFecha: json["VacunaFecha"],
      );

  Map<String, dynamic> toJson() => {
        "IdVacuna": idVacuna,
        "DescCodigo": descCodigo,
        "DescVacuna": descVacuna,
        "IdDosis": idDosis,
        "NroDosis": nroDosis,
        "DescDosis": descDosis,
        "VacunaLote": vacunaLote,
        "VacunaFabricante": vacunaFabricante,
        "IdEstablecimiento": idEstablecimiento,
        "Codunico": codunico,
        "EstNombre": estNombre,
        "VacunaFecha": vacunaFecha,
      };
}
