import 'package:eazy_app/Pages/eazy_visits.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:eazy_app/Pages/customer_check.dart/second.dart';
import 'package:eazy_app/Pages/customer_check.dart/third.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    Color myColor = Color(0xff4044fc);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
            margin: EdgeInsets.only(top: height * 0.04),
            height: height * 0.8,
            child: Column(
              children: <Widget>[
                Container(
                  height: height * 0.1,
                  margin: EdgeInsets.only(top: height * 0.05),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/eazyapp-logo-blue.png'),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                Padding(
                  padding : EdgeInsets.only(left : width*0.1),
                  child : Text(
                  'UrbanPlace Welcomes you to , UrbanPlace Project',
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ),
                
                SizedBox(height: height * 0.01),
                Container(
                  margin: EdgeInsets.only(top: height*0.015, left: width * 0.050 ,  right: width*0.050),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: myColor),
                      top: BorderSide(color: myColor),
                      left: BorderSide(color: myColor),
                      right: BorderSide(color: myColor),

                    ),
                  ),
                  child: TextFormField(
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: myColor, fontSize: 16),
                    ),
                    autovalidate: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.phone, color: myColor, size: 20),
                      border: InputBorder.none,
                      hintText: 'Enter First Name',
                      hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Container(
                  margin: EdgeInsets.only(top: height*0.015, left: width * 0.050 ,  right: width*0.050),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: myColor),
                      top: BorderSide(color: myColor),
                      left: BorderSide(color: myColor),
                      right: BorderSide(color: myColor),

                    ),
                  ),
                  child: TextFormField(
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: myColor, fontSize: 16),
                    ),
                    autovalidate: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.phone, color: myColor, size: 20),
                      border: InputBorder.none,
                      hintText: 'Enter Last Name',
                      hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                ),
                SizedBox(height : height*0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        textStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EazyVisits(),
                          ));
                      },
                      child: Text('Go back'),
                    ),
                    SizedBox(width : width*0.04),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: myColor,
                        textStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThirdPage(),
                          ));
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
            //color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}
