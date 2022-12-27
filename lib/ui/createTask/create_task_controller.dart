import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class CreateTaskController{

  TextEditingController taskController = TextEditingController();

  BehaviorSubject<String> streamSelectDate = BehaviorSubject<String>();

  void addTask(){

  }

  DateTime pickDate(String value){

    DateTime date = DateTime.now();

    if(value == "Today"){
      return date;
    }else if(value == "Tomorrow"){
      
      return  date.add( const Duration(days: 1));
    }else{
      return date;
    }
  }

}