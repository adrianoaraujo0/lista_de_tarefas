import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/menu/menu_page.dart';
import 'package:lista_de_tarefas/ui/menu/menu_repository.dart';
import 'package:rxdart/subjects.dart';


class DrawerComponentController{

  MenuRepository menuRepository = MenuRepository();
  BehaviorSubject<bool> streamDrawer = BehaviorSubject<bool>();

  void backup(BuildContext context) async{

   streamDrawer.sink.add(true);

   QuerySnapshot<Map<String, dynamic>> tasksFirebase = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.email).collection("tasks").get();
   List<String> uuidTasksObjectBox = menuRepository.findAllTasks().map((e) => e.uuid!).toList();

   for(QueryDocumentSnapshot<Map<String, dynamic>> taskFirebase in tasksFirebase.docs) {
    if(!uuidTasksObjectBox.contains(taskFirebase.data()["uuid"])){
      menuRepository.updateTask(Todo.fromMap(taskFirebase.data()));
    }
   }
 
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
       streamDrawer.sink.add(false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MenuPage()));
    });
  }

}