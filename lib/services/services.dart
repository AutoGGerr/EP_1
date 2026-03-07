import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../screens/auth.dart';
import '../screens/fire.dart';
import '../screens/hello.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




Future<String?> checkCurrrentUser() async{ //запись текущего айди окак!
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('docId');
}


Future<String?> checkCurrrentUserName() async{ //запись текущего пидораса
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userCurrentName');
}


Future<DateTime?> checkLastSeen() async{ //запись последнего посещения(вызываемая функция)
  final prefs = await SharedPreferences.getInstance();
  final lastCurrentSeen = prefs.getString('lastSeen');

  if(lastCurrentSeen == null) return null;
  return DateTime.parse(lastCurrentSeen);
}


Future<int?> seenCurrent(DateTime? lastSeen) async{ //передаём сюда переменную с DateTime в функцию имеющую int.
  final nowSeen = DateTime.now();
  if(lastSeen == null) return null;
  return nowSeen.difference(lastSeen).inHours;
}


void incrementFire() async{ //фунция прибавления огонька в fire.dart и запись в FireBase
  await FirebaseFirestore.instance
  .collection('users')
  .doc(userId)
  .update({
    'fire': FieldValue.increment(1),
  });

  var snapshot = await FirebaseFirestore.instance //достаём текущий огонёк юзера по айди
  .collection('users')
  .doc(userId)
  .get();
  var fire = snapshot?['fire'];
  userFire = fire;
}

void regAuth() async{ //локальное сохранение авторизинован/не авторизирован в шаредпреференс
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('check', true);
}


bool checkActiveFire(DateTime? lastSeen) {
  if (lastSeen == null) return false;
  final now = DateTime.now();
  final hoursPassed = now.difference(lastSeen).inHours;
  return hoursPassed >= 24;
}