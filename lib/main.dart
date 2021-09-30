import 'package:eazy_app/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:eazy_app/Pages/login_page.dart';

import 'Pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(EazyApp());
}

class EazyApp extends StatelessWidget {

  clearData() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthService.getToken(),
        builder : ( _,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if (snapshot.hasData){
            clearData();
            return LoginPage();
            
          }
          else {
            return LoginPage();
          }
        }
      ),
    );
  }
}