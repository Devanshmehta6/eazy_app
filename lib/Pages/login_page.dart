// import 'dart:js';

import 'package:eazy_app/Services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:eazy_app/Services/api.dart';
import 'package:eazy_app/Pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_session/flutter_session.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  bool isHiddenPassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;

    bool isLoggedIn = false;

    // callLoginApi() {
    //   final service = ApiServices();
    //   service.apiCallLogin(
    //     {
    //       "username": emailController.text,
    //       "password": passController.text,
    //     },
    //   ).then((value) async {
    //     if (value.error != null) {
    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(SnackBar(content: Text('Invalid credentials')));
    //       print("get data >>>>> " + value.error!);
    //     } else {
    //       print(value.token!);         //PRINTS THE TOKEN IN THE CONSOLE

    //         String sessionId = await FlutterSession().get('session') ;
    //        print('Session id from tc ::::: $sessionId');
    //        setState(() {
    //          isLoggedIn = true;

    //        });
    //       final pref = await SharedPreferences.getInstance();
    //       pref.setBool('isLoggedIn', isLoggedIn);
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => Dashboard()),
    //        );
    //     }
    //   });
    // }

    // getData() async {
    //   final pref = await SharedPreferences.getInstance();
    //   final data = pref.getString('token');
    //   print('yE : $data');
    // }

    var authInfo;
    dynamic login(BuildContext context) async  {

      authInfo = AuthService();
      print("============== >>>> ${emailController.text} ");
      print("============== >>>> ${passController.text} ");
      final res = await authInfo.login(emailController.text , passController.text);
      final data = jsonDecode(res.body) as Map<String , dynamic>;
      final headers = res.headers.toString();
      final str = headers;
      final start = 'sessionid=';
      final end = '; expires=';
      final startIndex = str.indexOf(start);
      final endIndex = str.indexOf(end, startIndex + start.length);
      final id = str.substring(startIndex + start.length, endIndex);
      await FlutterSession().set('session', id);
      print('ytytytytytytytytytytyt : $id');
     
      print("============== >>>> ${res.headers} ");
      print("============== >>>> ${res.body} ");
      if(res.statusCode != 200){
        print('error! inside login page');
      }else {
        
        AuthService.setToken(data['token'], data['refreshToken']);
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
           );
          //  setState(){
            isLoggedIn=true;
          // }
        final pref = await SharedPreferences.getInstance();
        final islog = pref.setBool('log' , isLoggedIn);
        return data;
      }
    }

    // Future<void> loginApi() async {
    //   if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
    //     var response = await http.post(
    //       Uri.parse("https://geteazyapp.com/api/login"),
    //       body: ({
    //         'username ': emailController.text,
    //         'password': passController.text
    //       }),
    //     );
    //     if(response.statusCode==200){
    //       Navigator.push(context , )
    //     }
    //   }
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 200, right: 165),
                  child: Text(
                    'Welcome back!',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.001),
                Container(
                  padding: EdgeInsets.only(right: 140),
                  child: Text(
                    'Please Login to continue',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 140, left: 8, right: 8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: width - 0.3,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade100),
                                ),
                              ),
                              child: TextFormField(
                                controller: emailController,
                                autovalidate: true,
                                validator:
                                    EmailValidator(errorText: 'Invalid Email'),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.email,
                                      color: Colors.blue.shade800, size: 20),
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.025),
                            Container(
                              width: width - 0.3,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade100))),
                              child: TextFormField(
                                controller: passController,
                                autovalidate: true,
                                obscureText: isHiddenPassword,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: _togglePass,
                                    child: Icon(
                                        isHiddenPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.blue.shade800,
                                        size: 20),
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.001),
                            Container(
                              padding: EdgeInsets.only(left: 210),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side:
                                      BorderSide(width: 0, color: Colors.white),
                                ),
                                child: Text('Forgot Password?',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500),
                                    )),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(height: height * 0.04),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .3),
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                              height: height * 0.05,
                              width: width - 0.02,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue.shade800),
                                child: isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 24),
                                          Text(
                                            'Please Wait',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Text(
                                        'Login',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                onPressed: () {
                                  setState(
                                    () => isLoading = true,
                                  );
                                  login(context);
                                  setState(
                                    () => isLoading = false,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePass() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }
}
