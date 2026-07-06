import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/todo_screen.dart'; // Points to your screens folder

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // This initializes Firebase using the google-services.json file you just added!
  await Firebase.initializeApp(); 
  
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoList(),
    );
  }
}