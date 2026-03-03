import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

Future<String?> checkCurrrentUser() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('docId');
}


Future<String?> checkCurrrentUserName() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userCurrentName');
}


Future<DateTime?> checkLastSeen() async{
  final prefs = await SharedPreferences.getInstance();
  final lastCurrentSeen = prefs.getString('lastSeen');

  if(lastCurrentSeen == null) return null;
  return DateTime.parse(lastCurrentSeen);
}



Future<int?> seenCurrent(DateTime? lastSeen) async{ //передаём сюда переменную с DateTime в функцию имеющую int.
  final nowSeen = DateTime.now();
  if(lastSeen == null) return null;
  return nowSeen.difference(lastSeen).inSeconds;
}

