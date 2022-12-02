import 'dart:async';

import 'package:festivalmanager/UserManager.dart';

import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ValidQRWidget extends StatefulWidget {
  int destroyTime = 0;
  int permissionId = 0;
  ValidQRWidget(int id, int time, {Key? key}) : super(key: key){ permissionId = id; destroyTime = time;}

  @override
  _ValidQRWidgetState createState() => _ValidQRWidgetState();
}

class _ValidQRWidgetState extends State<ValidQRWidget> {
  Timer? timer;
  @override
  void dispose() {
    // TODO: implement dispose
   if(timer!.isActive) {
     timer?.cancel();
   }
  }
  @override
  Widget build(BuildContext context) {
    String id = UserCredential.rank[widget.permissionId];
    Timer timer = Timer(Duration(seconds: widget.destroyTime), () => Navigator.pop(context));
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/check.png',
          width: 150,
          height: 150,
          fit: BoxFit.fitHeight,
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Valid QR Code!',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).title3,
              ),
            ],
          ),
        ),
        Text(
          'Permission Level : $id',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
          child: FFButtonWidget(
            onPressed: () async {
              Navigator.pop(context);
            },
            text: 'Check Stamp',
            options: FFButtonOptions(
              width: 170,
              height: 50,
              color: Color(0xFFC30E2E),
              textStyle: FlutterFlowTheme.of(context).subtitle2?.override(
                fontFamily: 'Lexend Deca',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              elevation: 2,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
      ],
    );
  }
}
