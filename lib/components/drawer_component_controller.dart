import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/menu/menu_repository.dart';

class DrawerComponentController{
  MenuRepository menuRepository = MenuRepository();


  void backup() async{
    print("fzd b");
   QuerySnapshot<Map<String, dynamic>> tasks = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.email).collection("tasks").get();
    for (var element in tasks.docs) {
      menuRepository.updateTask(Todo.fromMap(element.data()));
    }

  }

}