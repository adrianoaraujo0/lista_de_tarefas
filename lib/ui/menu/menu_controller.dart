import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lista_de_tarefas/login/login_page.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/menu/menu_repository.dart';
import 'package:rxdart/subjects.dart';

class MenuController{

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  MenuRepository menuRepository = MenuRepository();
  BehaviorSubject<List<Todo>> streamTasks = BehaviorSubject<List<Todo>>();
  BehaviorSubject<bool> streamIconDeleteTasks = BehaviorSubject<bool>();
  BehaviorSubject<String> streamFilterTasks = BehaviorSubject<String>();

  void updatelistTasks()=> streamTasks.sink.add(menuRepository.findAllTasks());

  void updateTask(Todo todo, String buttonPressed){

      todo.itsDone = !todo.itsDone!; 
      menuRepository.updateTask(todo);
      streamIconDeleteTasks.sink.add(completedTasks().isNotEmpty);

    if(buttonPressed == "All tasks"){
      updatelistTasks();
    }else{
      streamTasks.sink.add(menuRepository.findTasksCompleted(!todo.itsDone!));
    }
  }

  List<Todo> completedTasks()=> menuRepository.findAllTasks().where((element) => element.itsDone == true).toList();

  void deleteTask(){
    if(completedTasks().isNotEmpty){
      menuRepository.deleteTask(completedTasks().map((e) => e.id!).toList());
      updatelistTasks();
      streamIconDeleteTasks.sink.add(completedTasks().isNotEmpty);
    }
  }

  void filterTasks(String name){

    if(name == "All tasks"){

      updatelistTasks();

    }else if(name == "Pending"){
      streamTasks.sink.add(menuRepository.findTasksCompleted(false));

    }else if(name == "Completed"){
     
      streamTasks.sink.add(menuRepository.findTasksCompleted(true));

    }
  }
 
  Future<void> signOut(BuildContext context) async{
    GoogleSignIn a = GoogleSignIn();
    await FirebaseAuth.instance.signOut().whenComplete(
      (){
        if(FirebaseAuth.instance.currentUser == null){
          a.signOut();
          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      }
    );
  }

  Future<void> teste() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      log("I am connected to a mobile network");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      log("I am connected to a wifi network");
    }
  }
}