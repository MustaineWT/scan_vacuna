import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vac_card/app/data/authentication/services/authentication.dart';
import 'package:vac_card/app/data/data_user/data_user.dart';
import 'package:vac_card/app/data/data_user/models/user_data.dart';
import 'package:vac_card/app/pages/detail/view/detail_page.dart';
import 'package:vac_card/injection_container.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Barcode? result;
  QRViewController? controller;
  bool _validateQRStatus = true;
  bool _dataLoaded = false;
  bool _vacunateStatus = true;
  UserDataModel? _userDataModel;
  LoginResponse? _loginResponse;
  set dataLoaded(bool value) {
    setState(() {
      _userDataModel = null;
      result = null;
      _validateQRStatus = true;
      _dataLoaded = false;
    });
  }

  Position? position;
  String? currentLocation;
  double? coordy;
  double? coordx;
  String? messageError;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Future<void> formatDataResponse(String? scanData) async {
    setState(() {
      _isLoading = true;
    });

    String? texto = scanData?.substring(scanData.indexOf('Tk=') + 3);
    _userDataModel = await sl<RemoteDataUserRepository>().getDataUser(texto!);

    if (_userDataModel != null) {
      _loginResponse =
          await sl<LocalAuthenticationRepository>().getSessionData();
      await getCurrentLocation();
      await sl<RemoteAuthenticationRepository>().saveDataUser(
          texto,
          _loginResponse!.user!.accessToken!,
          coordx!,
          coordy!,
          _userDataModel!);
      setState(() {
        _validateQRStatus = true;
        _vacunateStatus =
            _userDataModel!.datas!.vacunas!.length > 1 ? true : false;
        _dataLoaded = true;
        _isLoading = false;
      });
    } else {
      setState(() {
        _validateQRStatus = false;
        _isLoading = false;
      });
    }
  }

  Future<void> getCurrentLocation() async {
    /* LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        currentLocation = "Permission Denied";
        coordx = -77.2007117;
        coordy = -12.0941172;
      } else {
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        currentLocation = "latitude: ${position.latitude}" +
            " , " +
            "Logitude: ${position.longitude}";
        coordy = position.latitude;
        coordx = position.longitude;
      }
    } else {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation = "latitude: ${position.latitude}" +
          " , " +
          "Logitude: ${position.longitude}";
      coordy = position.latitude;
      coordx = position.longitude;
    } */
    coordy = 0;
    coordx = 0;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  bool? _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildQrView(context),
          ),
          _buildButtonBack(context),
          _buildButtonView(context),
          if (_dataLoaded) ...[
            _buildPoPupCard(
              context,
              _vacunateStatus,
              _userDataModel!,
            ),
          ],
          // ignore: unnecessary_null_comparison
          if (!_validateQRStatus) ...[
            _buildPoPupErrorQR(
              context,
            ),
          ],
          if (_isLoading!) ...[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: loadingScan(),
            ),
          ]
        ],
      ),
    );
  }

  Widget loadingScan() => Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text(
                'Obteniendo datos...',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      );

  Widget _buildPoPupErrorQR(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.red[500],
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
                    'Codigo QR no valido',
                    style: TextStyle(fontSize: 24, color: Colors.white),
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
                      onPressed: () {
                        dataLoaded = true;
                        this.controller!.resumeCamera();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPoPupCard(BuildContext context, bool validateQRStatus,
      UserDataModel userDataModel) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: validateQRStatus ? Colors.teal[500] : Colors.red[500],
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 230,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: Text(
                    userDataModel.datas!.nombres!,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Text(
                    'Dni: ${userDataModel.datas!.numDoc!}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Dosis:',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    for (int i = 0;
                        i < userDataModel.datas!.vacunas!.length;
                        i++) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: validateQRStatus
                                ? Colors.green[500]
                                : Colors.yellow[800],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              '${userDataModel.datas!.vacunas![i].nroDosis!}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  validateQRStatus ? 'DOSIS COMPLETA' : 'DOSIS INCOMPLETA',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
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
                      onPressed: () {
                        dataLoaded = true;
                        this.controller!.resumeCamera();
                      },
                      child: Icon(
                        validateQRStatus ? Icons.check_circle : Icons.close,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
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
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            userDataModel: userDataModel,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.search,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonBack(BuildContext context) => Positioned(
        top: 50,
        left: 20,
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
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      );

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
    var scanArea = MediaQuery.of(context).size.width * 0.87;

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
      result = scanData;
      if (result != null) {
        formatDataResponse(result!.code);
        this.controller!.pauseCamera();
      }
      //setState(() {});
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
