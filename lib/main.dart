import 'package:eazy_app/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:eazy_app/Pages/login_page.dart';

import 'Pages/dashboard.dart';

void main() {
  runApp(EazyApp());
}

class EazyApp extends StatelessWidget {
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
            return Dashboard();
          }
          else {
            return LoginPage();
          }
        }
      ),
    );
  }
}