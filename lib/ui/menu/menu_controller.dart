import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // late StreamSubscription<ConnectivityResult> connectivitySubscription;

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

  void deleteTask() async{
      await deleteTaskFirebase();
      menuRepository.deleteTask(completedTasks().map((e) => e.id!).toList());
      updatelistTasks();
      streamIconDeleteTasks.sink.add(completedTasks().isNotEmpty);
  }

 Future<void> deleteTaskFirebase() async{
  try{
    QuerySnapshot<Map<String, dynamic>> x = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.email).collection("tasks").get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> task in x.docs) {
        completedTasks().forEach((taskRemoved) { 
          if(task.data()["id"] ==  taskRemoved.id){
            print("vai remover ${task.data()["title"]}");
            FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.email).collection("tasks").doc(task.id).delete();
          }
        }
      );
    }
  }on FirebaseException catch(e){
    print(e.code);
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

  validateUser() async{

    QuerySnapshot<Map<String, dynamic>> tasksFirebase = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("tasks").get();
    List<int> idsTasksFirebase = tasksFirebase.docs.map((e) => e.data()["id"] as int).toList();
    idsTasksFirebase.sort();

    List<int> idsTasksObject = tasksFirebase.docs.map((e) => e.data()["id"] as int).toList();
    idsTasksObject.sort();

    print("box: ${idsTasksObject}");
    tasksFirebase.docs.map((e) => e.data()["id"]);
    print("firebase: ${idsTasksFirebase}");

    validateTask();
    // FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.email);
    // menuRepository.findAllTasks().forEach((element) {
    //   FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("tasks").add(
    //     {"id": element.id ,"title" : element.title, "date" : element.dateTime, "itsDone" : element.itsDone}
    //   );
    // });
  }

  validateTask() async{

    QuerySnapshot<Map<String, dynamic>> tasksFirebase = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).collection("tasks").get();
    List<Todo> tasksObjectBox = menuRepository.findAllTasks();
    List<int> tasks = tasksFirebase.docs.map((e) => e.data()["id"] as int).toList();

    tasksObjectBox.forEach((element) => tasks.forEach((element) { }));

    tasks.forEach((element) {
      // print(element);
    });

    tasksObjectBox.forEach((taskObjectBox) {
      // print("${taskObjectBox.title} exists? ${tasks.contains(taskObjectBox.id)}");
    });
  }

}