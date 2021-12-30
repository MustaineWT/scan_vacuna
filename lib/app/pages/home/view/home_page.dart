import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vac_card/app/pages/login/view.dart';
import 'package:vac_card/app/pages/scan/view.dart';

import 'home_vm.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(),
          child: Consumer<HomeViewModel>(
            builder: (_, HomeViewModel homeViewModel, __) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: Icon(
                          Icons.exit_to_app,
                          size: 40,
                          color: Colors.red[300],
                        ),
                        onPressed: () {
                          homeViewModel.logOff();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      const LoginPage()),
                              (Route<dynamic> route) => false);
                        }),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  Text(
                    homeViewModel.name ?? '',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 100,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const Text(
                    'Escaner QR \nde vacunación',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    'Consulta el carnet de vacunación de tus clientes para un mejor control de ingreso a tu negocio.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.teal),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScanPage(),
                        ),
                      ),
                      child: const Text(
                        'Escanear ahora!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  Center(
                    child: Text('v.1.0.1'),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
