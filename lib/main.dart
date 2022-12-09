import 'package:flutter/material.dart';
import 'package:flutter_task_finn/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_task_finn/screens/list_screen.dart';

import 'screens/login.dart';
import 'screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          hintColor: Color(0xFFC0F0E8),
          primaryColor: Color(0xFF80E1D1),
          fontFamily: "Montserrat",
          canvasColor: Colors.transparent),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

