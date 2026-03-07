import 'dart:collection';
import 'package:flutter/material.dart';
import '../main.dart';
import './hello.dart';
import '../routes/routes.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/services.dart';
import 'dart:async';




class Fire extends StatefulWidget {
  const Fire({super.key});
  @override
  
  State<Fire> createState() => _FireState();

}
class _FireState extends State<Fire> {

  @override
  Future<void> getUsers() async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    var doc = snapshot.docs;
  }  
  
    
  Widget build(BuildContext context) {
    
    
    return Stack(
      
      children: [
        SizedBox.expand(
          child: Image.asset('assets/fire_wallpaper.jpg', fit: BoxFit.cover,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          
          body: SafeArea(
            child: Column(
            children: [
              Center(
                child: Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(20),
                      color: const Color.fromARGB(26, 255, 87, 87),
                    ),
                    width: 330,
                    height: 520,
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset('assets/fire.png'),
                          Text('$currrentFire', style: TextStyle(
                            fontSize: 50,
                            color: const Color.fromARGB(143, 184, 0, 0),
                          ),)
                        ]
                    )
                  )
                ),

                  SizedBox(height: 20,),
                  Container(

                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(20),
                    color: const Color.fromARGB(26, 255, 255, 255),
                  ),
                  width: 330,
                  height: 170,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Opacity(opacity: 0.5),
                      Text.rich(TextSpan(
                    text: 'Прошло: ',
                      style: TextStyle(
                      fontSize: 30,
                      color: const Color.fromARGB(132, 255, 255, 255),
                    
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '$lastHours/24 часов',
                      style: TextStyle(
                      fontSize: 30,
                      color: const Color.fromARGB(159, 255, 0, 0)
                    ),
                    )
                  ]
                  ), 
                      style: TextStyle(
                        fontSize: 30,
                        color: const Color.fromARGB(122, 176, 0, 0)
                      )),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(200, 70),
                          backgroundColor: const Color.fromARGB(193, 230, 230, 230),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed:isActive?() async { 
                          final prefs = await SharedPreferences.getInstance();

                          DateTime lastSeenCurrent = DateTime.now();
                          final isoLastSeen = lastSeenCurrent.toIso8601String();
                          await prefs.setString('lastSeen', isoLastSeen);
                          isActive = false;
                          lastSeen = await checkLastSeen();
                          lastHours = await seenCurrent(lastSeen); //разница lastSeen и nowSeen
                          setState((){
                            incrementFire();
                            currrentFire = currrentFire + 1;
                          });  
                        }:null, 
                        child: Text('Продлить', style: TextStyle(
                          color: const Color.fromARGB(185, 255, 255, 255),
                          fontSize: 20
                    ),)
                    ),
                   ],
                    ),
                  ),
                 ), 
                ]
                ),
              ) 
            ]
          ))
        )        
      ]
    );
  }
}