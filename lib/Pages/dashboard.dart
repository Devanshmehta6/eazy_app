import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:eazy_app/Pages/drawer_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:eazy_app/Services/DashboardJson.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map mapResponse = {};
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
      if (response.statusCode == 200) {
        setState(() {
          mapResponse = json.decode(response.body);
        });
      }
      print('RESPONSE BODY : ${response.body}');
      final entireJson = jsonDecode(response.body);

      //FetchData fetchData = FetchData.fromJson(entireJson);
      //print(entireJson[0]['Name']);
      //naam = entireJson[0]['Name'];

    } else {
      print('Logged out ');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
                'Welcome',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 3),
              mapResponse == null ? Container() : 
              Text(
                mapResponse['Name'].toString(),
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
              Total(context),
              Direct(context),
              CP(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget CP(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    //sabKuch();
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          height: height * 0.25,
          width: width,
          color: Colors.red.shade400,
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Total Walkins - CP',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    DateFormat("dd-MM-yyyy").format(
                      DateTime.now(),
                    ),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  //SizedBox(width : 50),
                  mapResponse == null ? Container() : 
                  Text(
                    mapResponse['cp_customers'].toString(),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 38),
              Container(
                // padding : EdgeInsets.only(bottom: 20),
                margin: EdgeInsets.only(bottom: 20),
                child: Icon(Icons.person_sharp, size: 110),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget Direct(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    //sabKuch();
    return Column(
      children: <Widget>[
        SizedBox(height: 25),
        Container(
          height: height * 0.25,
          width: width,
          color: Colors.green.shade300,
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Total Walkins - Direct',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    DateFormat("dd-MM-yyyy").format(
                      DateTime.now(),
                    ),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  //SizedBox(width : 50),
                  mapResponse == null ? Container() : 
                  Text(
                    mapResponse['direct_customers'].toString(), //'$direct_customers',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Container(
                // padding : EdgeInsets.only(bottom: 20),
                margin: EdgeInsets.only(bottom: 20),
                child: Icon(Icons.person_sharp, size: 110),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget Total(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    //sabKuch();
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          height: height * 0.25,
          width: width,
          color: Colors.blue.shade300,
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Total Visits',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    DateFormat("dd-MM-yyyy").format(
                      DateTime.now(),
                    ),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  //SizedBox(width : 50),
                  mapResponse == null ? Container() : 
                  Text(
                    mapResponse['total_customers'].toString(), //"$total_customers",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 110),
              Container(
                // padding : EdgeInsets.only(bottom: 20),
                margin: EdgeInsets.only(bottom: 20),
                child: Icon(Icons.people_alt_sharp, size: 100),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
