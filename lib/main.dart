  import 'package:flutter/material.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:shared_preferences/shared_preferences.dart';

  import './screens/hello.dart';
  import './routes/routes.dart';
  import './screens/auth.dart';
  import './services/services.dart';


  String? userName;
  String? userId;
  int userFire = 0;
  int currrentFire = 0;
  bool isDisibled = false;
  DateTime? lastSeen;
  DateTime? nowSeen;
  int? lastHours;




  void main () async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    userId = await checkCurrrentUser();
    userName = await checkCurrrentUserName();
    lastSeen = await checkLastSeen();
    lastHours = await seenCurrent(lastSeen);
    print(lastHours);


    final prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('check') ?? false;
    runApp(MaterialApp(
        routes: routes,
        initialRoute: isLogin? '/hello': '/',
        debugShowCheckedModeBanner: false,
    ));
  }









