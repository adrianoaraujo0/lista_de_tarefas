import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/database/objectbox_database.dart';
import 'package:lista_de_tarefas/login/login_page.dart';
import 'package:lista_de_tarefas/main_controller.dart';
import 'package:lista_de_tarefas/ui/menu/menu_page.dart';

void validatorConnection(ConnectivityResult result) async{
  
 

}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ObjectBoxDatabase.create();
  await Firebase.initializeApp();

 runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    Connectivity().onConnectivityChanged.listen((event) {
      MainController.result = event;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const MenuPage();
          }          
            return LoginPage();
        }
      ),
    );
  }
}