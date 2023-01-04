import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/database/objectbox_database.dart';
import 'package:lista_de_tarefas/login/login_page.dart';
import 'package:lista_de_tarefas/ui/menu/menu_page.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';

void validatorConnection(ConnectivityResult result) async{

  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    runApp(const WithoutConnection());
  } else{
    runApp(const MyApp());
  }

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

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _connectivitySubscription.cancel();
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

class WithoutConnection extends StatelessWidget {
  const WithoutConnection({Key? key}) : super(key: key);
  
  @override
    Widget build(BuildContext context){
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(color: ListColors.purple)
        )
      );
    }
  }
