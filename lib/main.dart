import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sq/db/home.dart';
import 'dart:io';

import 'package:sq/pages/notepages.dart';
import 'package:sq/pdf1.dart';
import 'package:sq/sqlfileNote.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
