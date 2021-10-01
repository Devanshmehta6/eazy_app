import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:eazy_app/Pages/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter_session/flutter_session.dart';

class EazyVisits extends StatefulWidget {
  @override
  State<EazyVisits> createState() => _EazyVisitsState();
}

class _EazyVisitsState extends State<EazyVisits> {
  Map mapResponse = {};
  Future getData() async {
    final pref = await SharedPreferences.getInstance();

    final isLoggedIn = pref.getBool('log');

    if (isLoggedIn == true) {
      Uri url = Uri.parse(
          'https://geteazyapp.com/projects/urbanplace-project-by-urbanplace-210720084736-210720090839/visits/api');

      String sessionId = await FlutterSession().get('session');

      String csrf = await FlutterSession().get('csrf');

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
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade50,
        bottomNavigationBar: Container(
          height: height * 0.08,
          margin: EdgeInsets.only(top: 2),
          child: Column(
            children: [
              
            ],
          ),
        ),
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('OnGoing Site Visits' ,style : TextStyle(color: Colors.black , fontFamily: 'Poppins'),),
              ),
              Tab(
                child: Text('Completed Site Visits' , style: TextStyle(color: Colors.black , fontFamily: 'Poppins'),),
              ),
             
            ],
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            },
          ),
          iconTheme: IconThemeData(color: Colors.blue.shade800),
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              SizedBox(width: 280),
              Image.asset(
                'images/eazyapp-logo-blue.png',
                height: 48,
                width: 40,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 480),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Image.asset('images/user_image.png',
                          height: 100, width: 100),
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 9),
                            child: Text(
                              'Name : ', //'Name : ${mapResponse['customers_ser'][0]['first_name'].toString()} ${mapResponse['customers_ser'][0]['last_name'].toString()}',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 9),
                            child: Text(
                              'Phone : ',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 9),
                            child: Text(
                              'Allocated To : ',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60, bottom: 500),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Image.asset('images/user_image.png',
                          height: 100, width: 100),
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 9),
                            child: Text(
                              'Name : ', //'Name : ${mapResponse['customers_ser'][0]['first_name'].toString()} ${mapResponse['customers_ser'][0]['last_name'].toString()}',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 9),
                            child: Text(
                              'Phone : ',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 9),
                            child: Text(
                              'Allocated To : ',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
