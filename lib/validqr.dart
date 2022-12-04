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
                '인증되었습니다!',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).title2?.override(color: Colors.white),
              ),
            ],
          ),
        ),
        Text(
          '권한 레벨 : $id',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
      ],
    );
  }
}
