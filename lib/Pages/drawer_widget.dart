import 'dart:io';
import 'dart:convert';
import 'package:eazy_app/Pages/customer_check.dart/first.dart';
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
  List<User> users = [];

  Future<List<User>> getUsers() async {
    final pref = await SharedPreferences.getInstance();

    final isLoggedIn = pref.getBool('log');
    print('Logged in dashboard : $isLoggedIn');

    if (isLoggedIn == true) {
      Uri url = Uri.parse('https://geteazyapp.com/dashboard_api/');

      String sessionId = await FlutterSession().get('session');

      String csrf = await FlutterSession().get('csrf');

      final sp = await SharedPreferences.getInstance();
      String? authorization = sp.getString('token');
      final token = await AuthService.getToken();
      String? tokenn = authorization;
      final cookie = sp.getString('cookie');
      final settoken = 'Token ${token['token']}';
      print('Set token :: $settoken');

      final setcookie = "csrftoken=$csrf; sessionid=$sessionId";
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': settoken,
        HttpHeaders.cookieHeader: setcookie,
      });
      final jsonData = jsonDecode(response.body);
      final projectData = jsonData['projects'];

      for (var u in projectData) {
        User user = User(u["project_name"], u["project_url"]);
        users.add(user);
      }
      //return users;
    } else {
      print('Logged Out...');
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      child: Column(
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
          ListTile(
            title: Text(
              'Eazy Dashboard',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: myColor,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(),
                ),
              );
            },
          ),
          ExpansionTile(
            
            title: Text(
              'Eazy Visits',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: myColor,
                ),
              ),
            ),
            children: [
              Container(
                child: FutureBuilder(
                  future: getUsers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            
                            contentPadding: EdgeInsets.all(0),
                            dense: true,
                            visualDensity: VisualDensity(vertical: -4),
                            title: Row(
                              children: [
                                SizedBox(height: height * 0.05),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.18),
                                  child: Image.asset('images/bullet.jpg',
                                      height: 13),
                                ),
                                SizedBox(width: width * 0.05),
                                Text(
                                  snapshot.data[index].project_name,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Project extends StatefulWidget {
  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  Map mapResponse = {};
  List<User> users = [];

  late String token;
  late String settoken;

  Future<List<User>> getUsers() async {
    final pref = await SharedPreferences.getInstance();

    final isLoggedIn = pref.getBool('log');
    print('Logged in dashboard : $isLoggedIn');

    if (isLoggedIn == true) {
      Uri url = Uri.parse('https://geteazyapp.com/dashboard_api/');

      String sessionId = await FlutterSession().get('session');

      String csrf = await FlutterSession().get('csrf');

      final sp = await SharedPreferences.getInstance();
      String? authorization = sp.getString('token');
      final token = await AuthService.getToken();
      String? tokenn = authorization;
      final cookie = sp.getString('cookie');
      final settoken = 'Token ${token['token']}';
      print('Set token :: $settoken');

      final setcookie = "csrftoken=$csrf; sessionid=$sessionId";
      http.Response response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': settoken,
        HttpHeaders.cookieHeader: setcookie,
      });
      final jsonData = jsonDecode(response.body);
      final projectData = jsonData['projects'];

      for (var u in projectData) {
        User user = User(u["project_name"], u["project_url"]);
        users.add(user);
      }
      //return users;
    } else {
      print('Logged Out...');
    }
    return users;
  }

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
          onExpansionChanged: (e) {},
          children: [
            Expanded(
              child: SizedBox(
                height: 200,
                child: FutureBuilder(
                  future: getUsers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text('Loading..'),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                                'Name  : ${snapshot.data[index].project_name}'),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            // OutlinedButton(
            //     child: Text('uibgfu[qb'),
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => EazyVisits()));
            //     }),
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

class User {
  late String project_name;
  late String project_url;

  User(this.project_name, this.project_url);
}
