import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';

void main() async{
  runApp(const WithoutConnection());
}

class WithoutConnection extends StatefulWidget {
  const WithoutConnection({Key? key}) : super(key: key);

  @override
  State<WithoutConnection> createState() => _WithoutConnectionState();
}

class _WithoutConnectionState extends State<WithoutConnection> {

  @override
  void initState() {
    super.initState();
  }

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