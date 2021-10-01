import 'dart:io';
import 'dart:convert';
import 'package:eazy_app/Services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:eazy_app/Pages/dashboard.dart';
import 'package:eazy_app/Pages/eazy_teams.dart';
import 'package:eazy_app/Pages/eazy_visits.dart';
import 'package:eazy_app/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:dio/dio.dart' as http;
import 'package:eazy_app/Services/teams_json.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  Color myColor = Color(0xff4044fc);

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
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          padding: padding,
          children: <Widget>[
            Container(
              height: 165,
              child: DrawerHeader(
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
                child: Image.asset(
                  'images/urbanplace.png',
                ),
              ),
            ),
            
            buildMenuItem(
              text: 'EazyDashboard',
              onClicked: () => selectedItem(context, 0),
            ),
            Project(),
            const SizedBox(height: 10),
            ProjectTeams(),
            SizedBox(height: 15),
            Divider(color: Colors.black54),
            SizedBox(height: 15),
            buildMenuItem(
              text: 'Log Out',
              onClicked: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
                bool isLogged = pref.getBool('log');
                print('IS USER LOGGED IN AFTER LOGOUT PAGE ::::: $isLogged');
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMenuItem({
  required String text,
  Color myColor = const Color(0xff4044fc),
  VoidCallback? onClicked,
}) {
  final color = myColor;
  final fontFamily = 'Poppins';
  final fontSize = 16.0;

  return ListTile(
    title: Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
      ),
    ),
    onTap: onClicked,
  );
}

class Project extends StatefulWidget {
  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    final color = Color(0xff4044fc);
    final fontFamily = 'Poppins';
    final fontSize = 16.0;
    final fontWeight = FontWeight.w500;
    return Container(
        child: Theme(
      data: theme,
      child: Column(children: <Widget>[
        ExpansionTile(
          title: Text(
            'EazyVisits',
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontSize: fontSize,
            ),
          ),
          children: [
            Container(
              padding: EdgeInsets.only(left: 50),
              child: Row(
                children: <Widget>[
                  Image.asset('images/bullet.jpg', height: 15, width: 15),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EazyVisits(),
                          ));
                    },
                    child: Text(
                      'UrbanPlace Project',
                      style: TextStyle(
                          color: color,
                          fontSize: fontSize,
                          fontFamily: fontFamily,
                          fontWeight: fontWeight),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 0),
                    ),
                  ),
                ],

                //   Padding(
                //     padding: EdgeInsets.only(bottom: 3.7),
                //   )
                // ],
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}

class ProjectTeams extends StatefulWidget {
  @override
  State<ProjectTeams> createState() => _ProjectTeamsState();
}

class _ProjectTeamsState extends State<ProjectTeams> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    final color = Color(0xff4044fc);
    final fontFamily = 'Poppins';
    //final fontSize = 16.0;
    final fontWeight = FontWeight.w500;
    return Container(
      child: Theme(
        data: theme,
        child: Column(children: <Widget>[
          ExpansionTile(
            title: Text(
              'EazyTeams',
              style: TextStyle(
                color: color,
                fontFamily: fontFamily,
                fontSize: 16,
              ),
            ),
            children: [
              Container(
                padding: EdgeInsets.only(left: 50),
                child: Row(
                  children: <Widget>[
                    Image.asset('images/bullet.jpg', height: 15, width: 15),
                    OutlinedButton(
                      onPressed: () {
                        //sabKuch();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EazyTeams(),
                          ),
                        );
                      },
                      child: Text(
                        'UrbanPlace Project',
                        style: TextStyle(
                            color: color,
                            fontSize: 16,
                            fontFamily: fontFamily,
                            fontWeight: fontWeight),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white, width: 0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 3.7),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
      break;
  }
}
