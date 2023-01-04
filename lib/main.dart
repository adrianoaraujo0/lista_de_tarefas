import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/database/objectbox_database.dart';
import 'package:lista_de_tarefas/login/login_page.dart';
import 'package:lista_de_tarefas/ui/menu/menu_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ObjectBoxDatabase.create();
  await Firebase.initializeApp();

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            print(snapshot.data);
            return MenuPage();
          }          
            print(snapshot.data);
            return LoginPage();
        }
      ),
    );
  }
}



