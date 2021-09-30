import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class Total extends StatefulWidget {
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {

  // List data = [];
  // String mockData = '', total_customers = '';
  
  
  // Future<String?> postData() async {
  //   final url = Uri.parse('https://geteazyapp.com/dashboard_api/');
  //    final sp = await SharedPreferences.getInstance();
  //   String? authorization = sp.getString('token');
  //   String sessionId = await FlutterSession().get('session') ;
  //   print('Session id from tc ::::: $sessionId');
  //   http.Response response =
  //       await http.get(url ,  headers: {'Accept': 'appilication/json' , 'Authorization' : authorization});

  //   setState(() {
  //     mockData = response.body.toString();
  //   });
  //   return null;
  // }

  // Future decodeData() async {
  //   final List parsedData = await json.decode(jsonEncode(mockData));

  //   setState(() {
  //     total_customers = parsedData[0]['total_customers'].toString();
  //   });
  // }

  // Future sabKuch() async {
  //   postData().whenComplete(() async {
  //     await decodeData();
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    final height  = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    //sabKuch();
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          height: height*0.25,
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
                  Text(
                    '0',//"$total_customers",
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