import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vac_card/app/data/data_user/models/user_data.dart';

import 'detail_vm.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.userDataModel}) : super(key: key);
  final UserDataModel userDataModel;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<DetailViewModel>(
        create: (_) => DetailViewModel(),
        child: Consumer<DetailViewModel>(
          builder: (_, DetailViewModel detailViewModel, __) => Scaffold(
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
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          '/home', (Route<dynamic> route) => false)),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildDataUser(
                            context,
                            userDataModel.datas!.nombres!,
                            userDataModel.datas!.fechNacimiento!,
                            userDataModel.datas!.numDoc!,
                            userDataModel.datas!.idGenero!,
                          ),
                          const SizedBox(height: 16),
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'Vacunas aplicadas',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          for (int i = 0;
                              i < userDataModel.datas!.vacunas!.length;
                              i++) ...[
                            _buildVaccines(
                              context,
                              userDataModel.datas!.vacunas![i].descVacuna!,
                              userDataModel.datas!.vacunas![i].nroDosis!,
                              userDataModel
                                  .datas!.vacunas![i].vacunaFabricante!,
                              userDataModel.datas!.vacunas![i].estNombre!,
                              userDataModel.datas!.vacunas![i].vacunaFecha!,
                            ),
                            const SizedBox(height: 10),
                          ]
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}

Widget _buildVaccines(
  BuildContext context,
  String descVaccine,
  String nroDose,
  String maker,
  String instituteVaccine,
  String dateOfVaccine,
) =>
    Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Descripción vacuna:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              descVaccine,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Nro Dosis:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              nroDose,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Fabricante:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              maker,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Institución de vacunación:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              instituteVaccine,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Fecha vacunación:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dateOfVaccine,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );

Widget _buildDataUser(
  BuildContext context,
  String nameComplete,
  String dateOfBirth,
  String dni,
  String gender,
) =>
    Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nombre completo:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              nameComplete,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Fecha de nacimiento:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dateOfBirth,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Dni:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dni,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Genero:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              gender,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
