import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import './hello.dart';
import '../routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';


String? nameUser;
String? nameUser1;

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
  
}

class _AuthState extends State<Auth> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? nameError;
  String? passError;

  @override

  Future<void> getUsers() async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    var doc = snapshot.docs;
  }

  void checkAuth() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('check', true);

  }

  // void regName() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('name', nameController.text);
    // String? nameUser = prefs.getString('name') ?? '';
  // }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        WillPopScope(
          child: Text(''), 
          onWillPop: () async{
            return false;
          }),
        SizedBox.expand(
          child: Image.asset('assets/auth_wallpaper.jpg', fit: BoxFit.cover),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  Text(
                    "Авторизация",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32),
                  ),
                  SizedBox(height: 70),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: nameController,
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          cursorWidth: 1,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.account_box_outlined),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(31, 255, 255, 255),
                            labelText: 'Твоё имя',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorText: nameError
                          ),
                          
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Введите имя';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          cursorWidth: 1,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.password),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(31, 255, 255, 255),
                            labelText: 'Пароль',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorText: passError
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Введите пароль';
                            }
                            return null;
                          },
                          
                        ),
                        
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  SizedBox(
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async{
                            setState(() {
                              nameError = null;
                              passError = null;
                              nameUser = null;
                            });
                            if(!_formKey.currentState!.validate()) return;
                            try{
                              var snapshot = await FirebaseFirestore.instance
                              .collection('users')
                              .where('name', isEqualTo: nameController.text)
                              .get();
                              if(snapshot.docs.isEmpty){
                                setState(() {
                                  nameError = 'Пользователя нету';
                                });
                                return;
                              }

                              var userDoc = snapshot.docs.first;

                              if (userDoc['password'] != passwordController.text){
                                setState(() {
                                  passError = 'Неверный пароль';
                                });
                                return;
                              }
                              nameUser = userDoc['name'];
                              checkAuth();
                              Navigator.pushNamed(context, '/hello');
                            } catch(e){
                              print(e);
                            }
                            
                          },
                          child: Text(
                            "Войти",
                            style: TextStyle(
                              color: const Color.fromARGB(68, 0, 0, 0),
                              fontSize: 15,
                            ),
                          ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(31, 255, 255, 255),
                          ),
                        ),
                      ),
                      
                    ),
                  ),
                  SizedBox(height: 12,),
                  SizedBox(
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Reg()));
                          },
                          child: Text(
                            "Создать аккаунт",
                            style: TextStyle(
                              color: const Color.fromARGB(101, 141, 0, 0),
                              fontSize: 15,
                            ),
                          ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(31, 255, 254, 254),
                          ),
                        ),
                      ),
                      
                    ),
                  ),
                  Center(
                    child: Text(
                      "E.P.",
                      style: TextStyle(
                        fontSize: 160,
                        color: const Color.fromARGB(31, 255, 0, 0),
                      ),
                    ),
                  ),
                ], 
               )
              ),
             ),
            ),
           ),
          ]
         );
  }
}


class Reg extends StatefulWidget {
  const Reg({super.key});

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController replacePasswordController = TextEditingController();
  String? nameError;
  String? passError;


  @override

  Future<void> getUsers() async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    var doc = snapshot.docs;
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset('assets/auth_wallpaper.jpg', fit: BoxFit.cover),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                    "Создать аккаунт",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32),
                  ),
                  SizedBox(height: 70),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: nameController,
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          cursorWidth: 1,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.account_box_outlined),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(31, 255, 255, 255),
                            labelText: 'Введи имя аккаунта',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorText: nameError
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Введите имя';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          cursorWidth: 1,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.password),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(31, 255, 255, 255),
                            labelText: 'Пароль',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Введите пароль';
                            }  else if(value.length<5){
                              return 'Пароль должен содержать больше 5-ти символов';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: replacePasswordController,
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          cursorWidth: 1,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.password),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(31, 255, 255, 255),
                            labelText: 'Повторите пароль',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          validator: (value) {
                            if(replacePasswordController.text != passwordController.text){
                              return 'Пароли не совпадают';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                 
                  SizedBox(height: 30),
                  SizedBox(
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton (
                          onPressed: () async {
                              // if(_formKey.currentState!.validate()){
                              //    boxPersons.put('key_${nameController.text}', Person(name: nameController.text, password: passwordController.text, fire: 1, lastCheck: null));                                 
                              // }
                                  setState(() {
                                    nameError = null;
                                    passError = null;
                                  });

                                  if(!_formKey.currentState!.validate()) return;

                                  try{
                                    var snapshot = await FirebaseFirestore.instance
                                    .collection('users')
                                    .where('name', isEqualTo: nameController.text)
                                    .get();

                                    if(snapshot.docs.isNotEmpty){
                                      setState(() {
                                        nameError = 'Пользовователь с таким именем уже существует';
                                      });
                                      return;
                                    }
                                      else{
                                      await FirebaseFirestore.instance
                                    .collection('users')
                                    .add({
                                      'name': nameController.text, 
                                      'password': passwordController.text,
                                      'dataCreate': FieldValue.serverTimestamp(),
                                      'fire': 0
                                      });
                                    Navigator.pop(context);
                                    }
                                  } catch(e){
                                      print(e);
                                  }
                                },
                          child: Text(
                            "Создать аккаунт",
                            style: TextStyle(
                              color: const Color.fromARGB(68, 0, 0, 0),
                              fontSize: 15,
                            ),
                          ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(31, 255, 255, 255),
                          ),
                        ),
                      ),
                      
                    ),
                  ),
                  Center(
                    child: Text(
                      "E.P.",
                      style: TextStyle(
                        fontSize: 160,
                        color: const Color.fromARGB(31, 255, 0, 0),
                      ),
                    ),
                  ),
                  ],
                  
                )
                  
                  
                  // SizedBox(
                  //   child: Center(
                  //     child: SizedBox(
                  //       width: 300,
                  //       height: 50,
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             boxPersons.clear();
                  //           });
                  //         },
                  //         child: Text(
                  //           "Удалить данные",
                  //           style: TextStyle(
                  //             color: const Color.fromARGB(68, 0, 0, 0),
                  //             fontSize: 15,
                  //           ),
                  //         ),

                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: Color.fromARGB(31, 255, 255, 255),
                  //         ),
                  //       ),
                  //     ),
                      
                  //   ),
                  // ),
                  
              ),
            ),
          ),
        ),
      ],
    );
  }
}