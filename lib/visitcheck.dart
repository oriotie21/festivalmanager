import 'dart:convert';

import 'package:festivalmanager/ServerInfo.dart';
import 'package:festivalmanager/UserManager.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class VisitCheckWidget extends StatefulWidget {
  const VisitCheckWidget({Key? key}) : super(key: key);

  @override
  _VisitCheckWidgetState createState() => _VisitCheckWidgetState();
}

class _VisitCheckWidgetState extends State<VisitCheckWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List visitLog = [];
  List<int> visitBoothIdList = <int>[];
  //나의 부스 방문 기록
  Future<void> loadVisitLog() async {
    UserCredential user = UserCredential();
    int? bid = await user.getBoothID();
    Logger().v(bid);
    http.Response resp = await http.get(Uri.parse(ServerInfo.addr +"/api/visits/booth/"+bid.toString()));
    Logger().v(resp.body);
    visitLog = jsonDecode(resp.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            /*
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavBarPage(initialPage: 'ManagerPage'),
              ),
            );
          */
          },
        ),
        title: Text(
          '방문 기록',
          style: FlutterFlowTheme.of(context).title2?.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: FutureBuilder(
                future: loadVisitLog(),
                builder: (buildContext, asyncSnapshot) {
                if(asyncSnapshot == false){
                  return Text("Loading");
                }else{
                  //add int to list
                    return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child:

                      // Customize what your widget looks like when it's loading the first page.
                      ListView.builder(
                    itemCount: visitLog.length,
                    itemBuilder: (context, listViewIndex) {
                      Logger().v(visitLog.length);
                      var visit =
                          visitLog.elementAt(listViewIndex);
                      int visitId = visit["id"];
                      visitBoothIdList.add(visitId);
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color(0x230E151B),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 12, 0, 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "#$visitId " + visit["user_id"].toString()+"번째 유저",
                                        style:
                                            FlutterFlowTheme.of(context).title2,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 4, 0, 0),
                                            child: Text(
                                              DateFormat("yyyy-MM-dd HH:MM:ss").format(DateTime.parse(visit["start_time"])),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .subtitle2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              visit["end_time"] == null ?
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("스탬프 찍기"),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async{
                                            UserCredential credential = await UserCredential();
                                            http.Response resp = await http.put( Uri.parse(ServerInfo.addr+"/api/visits/"+visitBoothIdList.elementAt(listViewIndex).toString()));
                                            visitBoothIdList.removeAt(listViewIndex);
                                            setState(() {
                                            });
                                          },
                                          text: 'Edit',
                                          icon: Icon(
                                            Icons.approval,
                                            size: 35,
                                          ),
                                          options: FFButtonOptions(
                                            width: 50,
                                            height: 50,
                                            color: FlutterFlowTheme.of(context).tertiaryColor,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    ?.override(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.white,
                                                    ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      /*Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async{
                                            UserCredential credential = await UserCredential();
                                            http.Response resp = await http.delete( Uri.parse(ServerInfo.addr+"/visits/stamp?"
                                                +"jwttoken="+(await credential.getAccessToken())!+"&token_type="+"bearer"+"&visitid="+visitBoothIdList.elementAt(listViewIndex).toString()));
                                            visitBoothIdList.removeAt(listViewIndex);
                                            setState(() {
                                            });
                                          },
                                          text: 'Del.',
                                          icon: Icon(
                                            Icons.close,
                                            size: 15,
                                          ),
                                          options: FFButtonOptions(
                                            width: 50,
                                            height: 50,
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryColor,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    ?.override(
                                                      fontFamily: 'Outfit',
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ],
                              ) : Text("인증 왼료"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );}},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
