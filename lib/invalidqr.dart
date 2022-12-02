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
    Logger().v(widget.destroyTime);
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
                'Invalid QR Code!',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).title3,
              ),
            ],
          ),
        ),
        Text(
          'It will not be stamped :(',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
          child: FFButtonWidget(
            onPressed: () async {
              Navigator.pop(context);
            },
            text: 'ReCheck QR Code',
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
