import 'package:eliminate_procrastination/screens/auth.dart';
import 'package:flutter/material.dart';
import '../screens/auth.dart';
import '../screens/hello.dart';
import '../screens/fire.dart';
import 'package:shared_preferences/shared_preferences.dart';


final routes = {
  '/': (context) => const Auth(),
  '/hello':(context) => const Main(),
  '/fire': (context) => const Fire()
};