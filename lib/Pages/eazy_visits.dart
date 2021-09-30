import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:eazy_app/Pages/dashboard.dart';

class EazyVisits extends StatefulWidget {
  @override
  State<EazyVisits> createState() => _EazyVisitsState();
}

class _EazyVisitsState extends State<EazyVisits> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
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
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              width: double.infinity,
              child: Card(
                child: Container(
                  padding: EdgeInsets.only(top: 6),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '  Team Members - UrbanPlace Project',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          DateFormat("dd-MM-yyyy").format(
                            DateTime.now(),
                          ),
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: height*0.25,
              width : width,
              child: Card(
                child: Row(
                  children: <Widget>[
                    Image.asset('images/user_image.png',
                        height: 140, width: 130),
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
                            'Name : ',
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
                        // Container(
                        //   padding : EdgeInsets.only(left : 100),
                        //   child : ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     'Check Out : ',
                        //     style: GoogleFonts.poppins(
                        //       textStyle: TextStyle(
                        //         fontSize: 16,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // ),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}