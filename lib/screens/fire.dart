import 'dart:collection';
import 'package:flutter/material.dart';
import '../main.dart';
import './hello.dart';
import '../routes/routes.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Fire extends StatefulWidget {
  const Fire({super.key});
  @override
  State<Fire> createState() => _FireState();
  
}

class _FireState extends State<Fire> {

void incrementFire() async{
      await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({
        'fire': FieldValue.increment(1),
      });

      var snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .get();
      var fire = snapshot?['fire'];
      userFire = fire;
  }


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
        SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                SizedBox(height: 200,),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async{  
                            setState(() {
                              incrementFire();
                            });       
                        }, 
                        child: Text('+ к огню', 
                        style:
                        TextStyle(
                          color: Colors.red
                        ),)
                        ),
                        SizedBox(height: 50,),
                        
                        Text("Результат: ${userFire}", 
                          style: TextStyle(
                            fontSize: 30
                          ),
                          ),
                    ],
                  ),
                  
                    
                      































                      // SizedBox(
                      //   height: 200,
                      //     child:  ListView.builder(
                      //       itemCount: boxPersons.length,
                      //       itemBuilder: (context, index){
                      //         Person person = boxPersons.getAt(index);
                      //         return Text("Имя: ${person.name}", style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 10
                      //         ),);
                      //          }
                      //        )
                      //      ),
                      // SizedBox(
                      //   height: 200,
                      //     child:  ListView.builder(
                      //       itemCount: boxPersons.length,
                      //       itemBuilder: (context, index){
                      //         Person person = boxPersons.getAt(index);
                      //         return Text("Пароль: ${person.password}", 
                      //           style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 10
                      //         ),);
                      // }
                      // )
                      // )
                      
                    
                    ),
              ],
            )
          )
      ]
    );
  }
}