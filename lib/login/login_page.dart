import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListColors.purple,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/clipboard.png", color: ListColors.white, height: 120),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text("HELLO THERE!, \nWELCOME\nONBOARD!", style: TextStyle(color: ListColors.white, fontSize: 30)),
            ),
            Row(
              children: const [
                 Text("Sign In With Google")
              ],
            )
          ],
        ),
      ),
    );
  }
}