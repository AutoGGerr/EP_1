import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/hello.dart';
import './routes/routes.dart';
import './screens/auth.dart';

Future<String?> checkCurrrentUser() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('docId');
}


Future<String?> checkCurrrentUserName() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userCurrentName');
}



String? userName;
String? userId;
int userFire = 0;

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  userId = await checkCurrrentUser();
  userName = await checkCurrrentUserName();

  final prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool('check') ?? false;
  runApp(MaterialApp(
      routes: routes,
      initialRoute: isLogin? '/hello': '/',
      debugShowCheckedModeBanner: false,
  ));
}









