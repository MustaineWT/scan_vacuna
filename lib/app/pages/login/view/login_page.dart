import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_vm.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<LoginViewModel>(
        create: (_) => LoginViewModel(),
        child: Consumer<LoginViewModel>(
          builder: (_, LoginViewModel loginViewModel, __) => Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            "Vacuna Scan",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 34,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Text.rich(
                            TextSpan(
                              text:
                                  "Registrate en nuestra aplicación usando \n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: "tu cuenta de google",
                                  style: TextStyle(
                                      color: Colors.orange[600],
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          const CircleAvatar(
                            maxRadius: 50,
                            minRadius: 50,
                            backgroundImage: AssetImage('assets/profile.png'),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Iniciar Sesión",
                            style: TextStyle(color: Colors.teal, fontSize: 25),
                          ),
                          const SizedBox(height: 20),
                          FloatingActionButton.extended(
                            onPressed: loginViewModel.signInGoogle,
                            label: const Text("Ingresar con Google"),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            icon: Image.asset("assets/google.png",
                                width: 32, height: 32),
                          ),
                          const SizedBox(height: 20),
                          const Divider(
                            height: 20,
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                            color: Colors.teal,
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () async {
                                const url = "https://flutter.io";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
                                }
                              },
                              child: Text(
                                "Politicas de privacidad",
                                style: TextStyle(
                                  color: Colors.orange[600],
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'v1.0.1',
                              style: TextStyle(
                                color: Colors.orange[600],
                                fontSize: 10,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
