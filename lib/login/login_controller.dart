import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lista_de_tarefas/main_controller.dart';
import 'package:lista_de_tarefas/ui/menu/menu_page.dart';

class LoginController{



  Future<void> signInWithGoogle(BuildContext context) async {
    

    if (MainController.result == ConnectivityResult.none) {
      alertAboutConnection(context);
    }else{
      try{
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        // Trigger the authentication flow
        if(googleUser == null)return;

        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential).whenComplete((){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MenuPage()));
      });
      
      }on FirebaseAuthException catch(e){
        print(e.code == 'network_error');
      }
    }
    
  }

  void alertAboutConnection(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sem conexão.")));
  }

}