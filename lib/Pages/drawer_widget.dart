
import 'dart:io';
import 'dart:convert';
import 'package:eazy_app/Pages/customer_check.dart/first.dart';
import 'package:eazy_app/Services/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';

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
  bool pressed = false;

  // changeText() {
  //   if (pressed = true) {
  //     return Text(
  //       'True',
  //       style: TextStyle(color: Colors.red),
  //     );
  //   } else {
  //     return Text(
  //       'False',
  //       style: TextStyle(color: Colors.green),
  //     );
  //   }
  // }

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
            height: height * 0.2,
            padding: EdgeInsets.only(top: height * 0.01),
            child: DrawerHeader(
              padding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
              child: Image.asset(
                'images/urbanplace.png',
              ),
            ),
          ),
          //Divider(),
         // changeText(),
          // ListTile(
          //   title: Row(
          //     children: [
          //       Icon(FontAwesomeIcons.chartPie, color: myColor),
          //       SizedBox(width: width * 0.06),
          //       Text('EazyDashboard'),
          //     ],
          //   ),
          //   onTap: () {
          //     setState(() {
          //       pressed = false;
          //     });
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => Dashboard(),
          //       ),
          //     );
          //   },
          // ),
          SizedBox(height: height * 0.02),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Row(
                children: [
                  Icon(FontAwesomeIcons.users),
                  SizedBox(width: width * 0.06),
                  Text(
                    'EazyVisits',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: myColor,
                      ),
                    ),
                  ),
                ],
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
                            return Container(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: Row(
                                  children: [
                                    SizedBox(width: width * 0.08),
                                    Icon(FontAwesomeIcons.userClock),
                                    SizedBox(width: width * 0.05),
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        snapshot.data[index].project_name,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16, color: myColor),
                                      ),
                                    ),
                                  ],
                                ),
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
          ),
          SizedBox(height: height * 0.02),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Row(
                children: [
                  Icon(FontAwesomeIcons.userTie),
                  SizedBox(width: width * 0.06),
                  Text(
                    'EazyTeams',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: myColor,
                      ),
                    ),
                  ),
                ],
              ),
              children: [],
            ),
          ),
          SizedBox(height: height * 0.02),
          Divider(thickness: 0.3),
          ListTile(
            title: Row(
              children: [
                Icon(FontAwesomeIcons.signOutAlt),
                SizedBox(width: width * 0.06),
                Text(
                  'Log Out',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: myColor,
                    ),
                  ),
                ),
              ],
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
        ],
      ),
    );
  }
}

class User {
  late String project_name;
  late String project_url;

  User(this.project_name, this.project_url);
}
