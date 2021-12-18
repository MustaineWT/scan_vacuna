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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text(
            'Certificado de vacunación',
            style: TextStyle(color: Colors.black),
          ),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildBody(
              context,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBody(
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child:
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Nombre: \nWilliams M. Torres ',
                style: TextStyle(fontSize: 15, color: Colors.black),
              )
            ],
          ),
        ),
      )
    ]),
  );
}
