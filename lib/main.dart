import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'pages/todo.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(const MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        title: "My Todo App",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TodoListPage());
  }
}
