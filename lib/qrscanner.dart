import 'dart:async';
import 'dart:convert';

import 'package:festivalmanager/checkqr.dart';
import 'package:festivalmanager/invalidqr.dart';
import 'package:festivalmanager/validqr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'ServerInfo.dart';
import 'UserManager.dart';


class QrScanner extends StatefulWidget {
  State<QrScanner> createState() => _QrScanner();
}

class _QrScanner extends State<QrScanner> {
  Barcode? result;
  QRViewController? controller;
  String? msg;
  Timer? timer;

  void displayResultWidget(Widget widget) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: widget,
        );
      },
    ).then((value) => setState(() {}));
  }

  final qrKey = GlobalKey(debugLabel: "QR");

  Widget build(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    //double scanArea = MediaQuery.of(context).size.width * 0.3 *  MediaQuery.of(context).size.width * 0.3;
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.8,
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
      ),
    ]);
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      setState(() {
        result = scanData;
      });
      //?????? ?????? ????????? 0??? ??????, 1~??? ?????????, ?????????, ?????? ???????????? ????????????
     try {
       //????????? json ????????? ?????? ??????
       UserCredential user = UserCredential();
       Map<String, dynamic> r = jsonDecode(result!.code!);
       r['booth_id'] = await user.getBoothID();

       String payload = jsonEncode(r);
       Logger().v(payload);
       http.Response response =
       await http.post(Uri.parse(ServerInfo.addr + "/api/otp/auth"),
           headers: {"Content-Type": "application/json"},
           //?????? : {"username" : "sejong", "otppass" : "123456"}
           body: jsonEncode(r)).timeout(Duration(seconds: 1));
        Logger().v(response.body);
      if (response.body == null) {
    //???????????? ?????? ??????
      } else {
        Map<String, dynamic> content = jsonDecode(response.body);
        int id = content["permission"];
        //id??? ????????? ????????? ????????? ??????
        switch(id){
          case 0:
            displayResultWidget(InvalidQRWidget(WIDGET_DISPLAY_TIME));
            break;
          default:
            displayResultWidget(ValidQRWidget(id, WIDGET_DISPLAY_TIME));
        }
        setState(() {
          msg = UserCredential.rank.elementAt(id).toString();
        });
      }}catch(e){}
      timer = Timer(Duration(seconds: WIDGET_DISPLAY_TIME, microseconds: 300),() => {controller.resumeCamera()});
      
    }
      );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    timer?.cancel();
    super.dispose();
  }
}
