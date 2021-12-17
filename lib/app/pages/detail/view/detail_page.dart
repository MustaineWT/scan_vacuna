import 'package:flutter/material.dart';
import 'package:vac_card/app/data/data_user/data_user.dart';
import 'package:vac_card/app/data/data_user/models/user_data.dart';
import 'package:vac_card/injection_container.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.scanText}) : super(key: key);
  final String scanText;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  UserDataModel? userDataModel;
  Future<void> formatDataResponse(String scanData) async {
    String texto = scanData.substring(scanData.indexOf('Tk=') + 3);
    userDataModel = await sl<RemoteDataUserRepository>().getDataUser(texto);
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await formatDataResponse(widget.scanText);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Detalle'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (userDataModel != null)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: _buildBody(context, userDataModel!),
              ),
            if (userDataModel == null)
              const CircularProgressIndicator(
                value: null,
                color: Colors.red,
                strokeWidth: 7.0,
              ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBody(BuildContext context, UserDataModel userDataModel) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
      Widget>[
    Text(
      'responsetId: ${userDataModel.responsetId.toString()}',
    ),
    Text('messageId: ${userDataModel.messageId.toString()}'),
    Text('actions: ${userDataModel.actions}'),
    Text('state: ${userDataModel.state}'),
    Text('isNew: ${userDataModel.isNew.toString()}'),
    Text('success: ${userDataModel.success.toString()}'),
    Text('fecConsulta: ${userDataModel.data.fecConsulta}'),
    Text('fecGenerada: ${userDataModel.data.fecGenerada}'),
    Text('fecExpira: ${userDataModel.data.fecExpira}'),
    Text('idPersona: ${userDataModel.data.idPersona.toString()}'),
    Text('nombres: ${userDataModel.data.nombres}'),
    Text('fechNacimiento: ${userDataModel.data.fechNacimiento}'),
    Text('idGenero: ${userDataModel.data.idGenero}'),
    Text('numDoc: ${userDataModel.data.numDoc}'),
    Text('idTipoDoc: ${userDataModel.data.idTipoDoc.toString()}'),
    Text('descTipoDoc: ${userDataModel.data.descTipoDoc}'),
    Text('idPais: ${userDataModel.data.idPais}'),
    Text('descPais: ${userDataModel.data.descPais}'),
    Text('vacunaDosisAplico: ${userDataModel.data.vacunaDosisAplico}'),
    const Divider(
      color: Colors.black,
    ),
    for (int i = 0; i < userDataModel.data.vacunas.length; i++) ...<Widget>[
      Text('idVacuna: ${userDataModel.data.vacunas[i].idVacuna.toString()}'),
      Text(
          'descCodigo: ${userDataModel.data.vacunas[i].descCodigo.toString()}'),
      Text(
          'descVacuna: ${userDataModel.data.vacunas[i].descVacuna.toString()}'),
      Text('idDosis: ${userDataModel.data.vacunas[i].idDosis.toString()}'),
      Text('nroDosis: ${userDataModel.data.vacunas[i].nroDosis.toString()}'),
      Text('descDosis: ${userDataModel.data.vacunas[i].descDosis.toString()}'),
      Text(
          'vacunaLote: ${userDataModel.data.vacunas[i].vacunaLote.toString()}'),
      Text(
          'vacunaFabricante: ${userDataModel.data.vacunas[i].vacunaFabricante.toString()}'),
      Text(
          'idEstablecimiento: ${userDataModel.data.vacunas[i].idEstablecimiento.toString()}'),
      Text('codunico: ${userDataModel.data.vacunas[i].codunico.toString()}'),
      Text('estNombre: ${userDataModel.data.vacunas[i].estNombre.toString()}'),
      Text(
          'vacunaFecha: ${userDataModel.data.vacunas[i].vacunaFecha.toString()}'),
      const Divider(
        color: Colors.black,
      ),
    ]
  ]);
}
