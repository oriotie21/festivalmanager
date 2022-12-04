import 'package:festivalmanager/boothinfo.dart';
import 'package:festivalmanager/checkqr.dart';
import 'package:festivalmanager/visitcheck.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:logger/logger.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> pageList = <Widget>[EditBoothWidget(),CheckQRWidget(), VisitCheckWidget()];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      bottomNavigationBar: FloatingNavbar(
        onTap: (int val) {
          setState(() {
            pageIndex = val;
          });
        },
        currentIndex: pageIndex,
        backgroundColor: FlutterFlowTheme.of(context).alternateColor,
        selectedItemColor: FlutterFlowTheme.of(context).tertiaryColor,
        unselectedItemColor: FlutterFlowTheme.of(context).lineColor,
        selectedBackgroundColor: FlutterFlowTheme.of(context).lineColor,
        width: MediaQuery.of(context).size.width * 0.8,
        elevation: 0,
        borderRadius: 40,
        itemBorderRadius: 20,
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        padding: EdgeInsets.only(top: 8, bottom: 8),
        items: [
          FloatingNavbarItem(icon: Icons.store_outlined, ),
          FloatingNavbarItem(icon: Icons.qr_code, ),
          FloatingNavbarItem(icon: Icons.checklist,),
         // FloatingNavbarItem(icon: Icons.person,),
        ],
      ),

      body: SafeArea(
        child: pageList[pageIndex],
      ),
    );
  }
}
