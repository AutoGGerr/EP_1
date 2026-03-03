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
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Text("Твой уровень", 
              style: TextStyle(
                fontSize: 50,
                color: const Color.fromARGB(95, 0, 0, 0)
              ),
              ),
              SizedBox(height: 100,),
              Opacity(opacity: 0.5),
              ElevatedButton(
                onPressed:() async{
                  final prefs = await SharedPreferences.getInstance();

                  DateTime lastSeenCurrent = DateTime.now();
                  final isoLastSeen = lastSeenCurrent.toIso8601String();

                  await prefs.setString('lastSeen', isoLastSeen);
                  setState((){
                    incrementFire();
                    currrentFire = currrentFire + 1;
                  });  
                  lastSeen = await checkLastSeen();
                  lastHours = await seenCurrent(lastSeen);

                },
                child: Image.asset(
                  'assets/fire.png', 
                  color: const Color.fromARGB(160, 0, 0, 0),
                  
                )
              ),
              Text('$currrentFire', 
              style: TextStyle(
                fontSize: 30
              ))
                
            ],
          ))
        )        


        // SafeArea(
        //   child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center, 
        //       children: [
        //         SizedBox(height: 200,),
        //         Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               ElevatedButton(
        //                 onPressed: () async{  
        //                     setState(() {
        //                       incrementFire();
        //                       currrentFire = currrentFire + 1;
        //                     });       
        //                 }, 
        //                 child: Text('+ к огню', 
        //                 style:
        //                 TextStyle(
        //                   color: Colors.red
        //                 ),)
        //                 ),
        //                 SizedBox(height: 50,),
                        
        //                 Text("Результат: ${currrentFire}", 
        //                   style: TextStyle(
        //                     fontSize: 30
        //                   ),
        //                   ),
        //             ],
        //           ),
                  
                    
                      































        //               // SizedBox(
        //               //   height: 200,
        //               //     child:  ListView.builder(
        //               //       itemCount: boxPersons.length,
        //               //       itemBuilder: (context, index){
        //               //         Person person = boxPersons.getAt(index);
        //               //         return Text("Имя: ${person.name}", style: TextStyle(
        //               //           color: Colors.white,
        //               //           fontSize: 10
        //               //         ),);
        //               //          }
        //               //        )
        //               //      ),
        //               // SizedBox(
        //               //   height: 200,
        //               //     child:  ListView.builder(
        //               //       itemCount: boxPersons.length,
        //               //       itemBuilder: (context, index){
        //               //         Person person = boxPersons.getAt(index);
        //               //         return Text("Пароль: ${person.password}", 
        //               //           style: TextStyle(
        //               //           color: Colors.white,
        //               //           fontSize: 10
        //               //         ),);
        //               // }
        //               // )
        //               // )
                      
                    
        //             ),
        //       ],
        //     )
        //   )
      ]
    );
  }
}