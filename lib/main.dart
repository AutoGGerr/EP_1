import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/hello.dart';
import './routes/routes.dart';
import './screens/auth.dart';


void main () async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool('check') ?? false;

  runApp(MaterialApp(
      routes: routes,
      initialRoute: isLogin? '/hello': '/',
      debugShowCheckedModeBanner: true,
  ));
}



