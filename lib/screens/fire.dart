import 'dart:collection';
import 'package:flutter/material.dart';
import '../main.dart';
import './hello.dart';
import '../routes/routes.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Fire extends StatefulWidget {
  const Fire({super.key});
  @override
  State<Fire> createState() => _FireState();
}

class _FireState extends State<Fire> {

  @override

  Widget build(BuildContext context) {
    // Person person = boxPersons.getAt(0);
    return Stack(
      children: [
        
        SizedBox.expand(
          child: Image.asset('assets/fire_wallpaper.jpg', fit: BoxFit.cover,),
        ),
        SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 500,),
                Column(
                    children:[
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
                      
                    ] 
                    ),
              ],
            )
          )
      ]
    );
  }
}