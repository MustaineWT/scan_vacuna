import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vac_card/app/pages/detail/view/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Expanded(flex: 4, child: _buildQrView(context)),
        _buildButtonView(context),
        _buildPoPupCard(
            context, 'Williams M. Torres Bajonero', '45415098', true),
        if (result != null)
          _buildPoPupCard(
              context, 'Williams M. Torres Bajonero', '45415098', false),
      ],
    ));
  }

  Widget _buildPoPupCard(
      BuildContext context, String name, String dni, bool isVacunated) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: isVacunated ? Colors.teal[500] : Colors.red[500],
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(70),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 200,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    'Dni: $dni',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        primary: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(
                        isVacunated ? Icons.check_circle : Icons.close,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    isVacunated
                        ? ElevatedButton(
                            style: TextButton.styleFrom(
                              primary: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  scanText: 'result!.code.toString()',
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.search,
                              size: 60,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonView(BuildContext context) {
    return Positioned(
      top: 50,
      right: 50,
      child: Container(
        height: 50,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Center(
          child: ElevatedButton(
              style: TextButton.styleFrom(
                primary: Colors.transparent,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              child: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return describeEnum(snapshot.data!) == 'back'
                        ? const Icon(
                            Icons.camera_rear,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.camera_front,
                            color: Colors.white,
                          );
                  } else {
                    return const Icon(
                      Icons.local_fire_department_rounded,
                      color: Colors.white,
                    );
                  }
                },
              )),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null && result!.code!.length > 20) {
        controller.dispose();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
