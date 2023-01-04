import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/login/login_controller.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListColors.purple,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/clipboard.png", color: ListColors.white, height: 120),
                  const Text("HELLO THERE!, \nWELCOME\nONBOARD!", style: TextStyle(color: ListColors.white, fontSize: 30)),
                ],
              ),
            ),
            signIn(context)
            
          ],
        ),
      ),
    );
  }

  Widget signIn(BuildContext context){
    return InkWell(
      onTap: () => loginController.signInWithGoogle(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child:  Text("Sign In With Google", style: TextStyle(color: ListColors.white, fontSize: 15)),
          ),
          Container(
            height: 80,
            width: 100,
            decoration: const BoxDecoration(color: ListColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/google.png", height: 50),
              ],
            )
          )
        ],
      ),
    );
  }

}