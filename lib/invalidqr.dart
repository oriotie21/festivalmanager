import 'dart:async';

import 'package:logger/logger.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvalidQRWidget extends StatefulWidget {
  int destroyTime = 0;
  InvalidQRWidget(int time, {Key? key}) : super(key: key) { destroyTime = time;}

  @override
  _InvalidQRWidgetState createState() => _InvalidQRWidgetState();
}

class _InvalidQRWidgetState extends State<InvalidQRWidget> {
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
    Timer timer = Timer(Duration(seconds: widget.destroyTime), () => Navigator.pop(context));
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/X2.png',
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
                '인증에 실패했습니다',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).title2?.override(color: Colors.white),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
