import 'dart:convert';

import 'package:festivalmanager/ServerInfo.dart';
import 'package:festivalmanager/UserManager.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBoothWidget extends StatefulWidget {
  const EditBoothWidget({
    Key? key,
  }) : super(key: key);


  @override
  _EditBoothWidgetState createState() => _EditBoothWidgetState();
}

class _EditBoothWidgetState extends State<EditBoothWidget> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> boothData = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController(text: ' ');
    //getData();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

    void getData() async {

    UserCredential credential = await UserCredential();
    Map<String, dynamic> reqbody = Map<String, dynamic>();
    String? jwttoken = await credential.getAccessToken();
    String token_type = "bearer";
    String? username = await credential.getUsername(); //얘때문에
    http.Response resp = await http.get(Uri.parse(ServerInfo.addr+"/booth/info?"+
        "jwttoken="+jwttoken!+"&token_type="+token_type+"&username="+username!),
    );
    setState(() {
      boothData = jsonDecode(resp.body);
      textController1?.text = boothData['name'];
      textController2?.text = boothData['description'];
    });


  }
  void setData() async {
    UserCredential credential = UserCredential();
    int? boothId = await credential.getBoothID();
      http.Response resp = await http.put(Uri.parse(ServerInfo.addr+"/api/booth/"+boothId.toString()),
        headers: {"Content-Type" : "application/json"},  body : jsonEncode({"name" : textController1?.text.toString() ,
          "description" : textController2?.text.toString()
          }),
          );
      if(resp.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("업데이트 성공")));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resp.body)));
      }



    //  setState(() {
    //  });

  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.chevron_left_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            title: Text(
              '부스 정보 수정',
              style: FlutterFlowTheme.of(context).title2,
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          body: SafeArea(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x230E151B),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                      child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 0, 0),
                                child: Text(
                                  '부스 정보 수정',
                                  style: FlutterFlowTheme.of(context).title2,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 0),
                                child: TextFormField(
                                  controller: textController1,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '부스 이름',
                                    labelStyle:
                                    FlutterFlowTheme.of(context).subtitle2,
                                    hintText: ' ',
                                    hintStyle:
                                    FlutterFlowTheme.of(context).subtitle2,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    prefixIcon: Icon(
                                      Icons.store_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 0),
                                child: TextFormField(
                                  controller: textController2,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: '부스 소개',
                                    labelStyle:
                                    FlutterFlowTheme.of(context).subtitle2,
                                    hintText: ' ',
                                    hintStyle:
                                    FlutterFlowTheme.of(context).subtitle2,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    prefixIcon: Icon(
                                      Icons.segment,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 26),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 26),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              setData();

                                              /*
                                              final usersUpdateData =
                                              createUsersRecordData(
                                                displayName:
                                                textController1!.text,
                                                email: textController2!.text,
                                              );
                                              await columnUsersRecord.reference
                                                  .update(usersUpdateData);
                                              Navigator.pop(context);
                                            */},
                                            text: '수정하기',
                                            options: FFButtonOptions(
                                              width: 230,
                                              height: 50,
                                              color: Color(0xFFC30E2E),
                                              textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .subtitle1
                                                  ?.override(
                                                fontFamily: 'Outfit',
                                                color:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .white,
                                              ),
                                              elevation: 3,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                      ),
                    ),
                 ],

              ),
            ),
          ),
        );
      }
  }

