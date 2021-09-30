import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:eazy_app/Pages/drawer_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eazy_app/Pages/direct_customers.dart';
import 'package:eazy_app/Pages/cp_customers.dart';
import 'package:eazy_app/Pages/total_customers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String total = '';
  String map = '', total_customers = '';

  Future getData() async {
    final pref = await SharedPreferences.getInstance();

    final isLoggedIn = pref.getBool('log');
    if (isLoggedIn == true) {
      Uri url = Uri.parse('https://geteazyapp.com/dashboard_api/');
      print(" ================== $url");
      String sessionId = await FlutterSession().get('session');
      print(" ================== $sessionId");
      String csrf = await FlutterSession().get('csrf');
      print(" ================== $csrf");
      final sp = await SharedPreferences.getInstance();
      String? authorization = sp.getString('token');
      String? tokenn = authorization;
      final cookie = sp.getString('cookie');
      print('Drawer widget : $csrf');
      final setcookie = "csrftoken=$csrf; sessionid=$sessionId";
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: tokenn,
        HttpHeaders.cookieHeader: setcookie,
      });

      print(response.body);

      map = response.body.toString();
    } else {
      print('Logged out ');
    }
  }

  Future decodeData() async {
    final List<dynamic> parsedData = await json.decode(map);
    
      total_customers = parsedData[0]['Name'].toString();
      print('yayayayay ::::::: $total_customers');
    
  }

  Future sabKuch() async {
    getData().whenComplete(() async {
      await decodeData();
    });
  }

 

  @override
  Widget build(BuildContext context) {
    sabKuch();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          //centerTitle : true,
          iconTheme: IconThemeData(color: Colors.blue.shade800),
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Image.asset(
                'images/eazyapp-logo-blue.png',
                height: 48,
                width: 40,
              ),
              SizedBox(width: 63),
              Text(
                total_customers,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 3),
              Text(
                'Visit Manager',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                child: Card(
                  color: Colors.lightBlue.shade50,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                      Text(
                        'Dashboard',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Total(),
              Direct(),
              CP(),
            ],
          ),
        ),
      ),
    );
  }
}
