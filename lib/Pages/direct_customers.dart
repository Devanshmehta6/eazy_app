import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Direct extends StatefulWidget {
  @override
  _DirectState createState() => _DirectState();
}

class _DirectState extends State<Direct> {
  
  // List data = [];
  // String mockData = '', direct_customers = '';
  // Future<String?> postData() async {
  //   final url = Uri.parse('https://geteazyapp.com/dashboard_api/');
  //   final sp = await SharedPreferences.getInstance();
  //   String? authorization = sp.getString('token');
  //   http.Response response =
  //       await http.get(url, headers: {'Accept': 'appilication/json' , 'Authorization' : authorization!});

  //   setState(() {
  //     mockData = response.body.toString();
  //   });
  //   return null;
  // }

  // Future decodeData() async {
  //   final List parsedData = await json.decode(mockData);
  //   //print(parsedData[0]['cp_customers']);
  //   setState(() {
  //     direct_customers = parsedData[0]['direct_customers'].toString();
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
        SizedBox(height: 25),
        Container(
          height: height*0.25,
          width:width,
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
                  Text(
                    '0',//'$direct_customers',
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
}