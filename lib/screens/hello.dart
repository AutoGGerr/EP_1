import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './auth.dart';
import '../main.dart';
import '../routes/routes.dart';
import '../services/services.dart';
class Main extends StatelessWidget {
  const Main({super.key});

  @override

  
  Widget build(BuildContext context) {
    return const Home();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  Future<void> getUsers() async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    var doc = snapshot.docs;
  }  
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WillPopScope(
          child: Text(''), 
          onWillPop: () async{
            FocusScope.of(context).unfocus();
            return false;
          }),
          SizedBox.expand(
            child: Image.asset('assets/mw_v3.jpg', fit: BoxFit.cover,),
          ),
          Opacity(
            opacity: 0.13,
            child: Image.asset('assets/change.png'),
            ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(0, 230, 0, 0),
                  child: Text.rich(TextSpan(
                    text: 'Аккаунт: ',
                      style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(45, 255, 0, 0),
                    
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: userName,
                      style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(125, 255, 0, 0)
                    ),
                    )
                  ]
                  ))
                ),
                ],
                )
              ],
             ),
            ),
            
          SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(0, 270, 0, 0),
                    child: Text("E.P.",
                    style: TextStyle(
                      fontSize: 160,
                      color: const Color.fromARGB(45, 255, 0, 0)
                    ),
                    ),
                  ),
                ],
               ),
              ),
              Column(
                children:[ 
                  
                  SizedBox(height: 580),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                      Opacity(
                        opacity: 1,
                        child: ElevatedButton(
                          onPressed:() async{       
                            var snapshot = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .get();

                            var userData = snapshot.data();
                            var fire = userData?['fire'];
                            
                            userFire = fire;
                            currrentFire = fire;
                            lastHours = await seenCurrent(lastSeen);
                            isActive = checkActiveFire(lastSeen);
                            
                            Navigator.pushNamed(context, '/fire');
                          }, 
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 80),
                            backgroundColor: const Color.fromARGB(31, 255, 255, 255)
                          ),
                          child: Text("Начать | Продолжить",
                          style: 
                          TextStyle(
                            color: const Color.fromARGB(92, 255, 255, 255),
                            fontSize: 20
                          ),
                          )
                        ),
                      ),
                    ],
                ),
              ],
          ),
          Column(
            children: [
              SizedBox(height: 700,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ Opacity(
                    opacity: 1,
                    child: ElevatedButton(
                      onPressed:() async {
                        
                        showDialog(
                          context: context,
                           builder: (context){
                            return AlertDialog(
                              backgroundColor: const Color.fromARGB(31, 255, 0, 0),
                              title: Text('Вы уверены, что хотите выйти?', 
                              style: TextStyle(
                                color: const Color.fromARGB(87, 255, 255, 255)
                              ),),
                              actions: [
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(onPressed: () async{
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.setBool('check', false);
                                      Navigator.pushNamed(context, '/');
                                      }, child: Text('Да', style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight(500),
                                        color: const Color.fromARGB(255, 255, 0, 0)
                                      ),)
                                      ),
                                      TextButton(onPressed: (){
                                        
                                        Navigator.pop(context);
                                      }, child: Text('Нет', style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight(500),
                                        color: const Color.fromARGB(255, 157, 255, 0)
                                      ),)),     
                                    ]      
                              
                                    
                                  ),
                                )
                              ] 
                            );
                           });
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(31, 255, 255, 255)
                      ),
                      child: Text("Выйти из аккаунта",
                      style: 
                      TextStyle(
                        color: const Color.fromARGB(92, 255, 255, 255),
                        fontSize: 12
                      ),
                      )
                    ),
                  ),
                ]
              )
            ],
          )
        ]
      )
      );
  }
}