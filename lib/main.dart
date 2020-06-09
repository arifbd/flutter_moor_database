import 'package:flutter/material.dart';
import 'package:moordatabase/database/moor_database.dart';
import 'package:moordatabase/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => MyMoorDatabase().noteDao,
      child: MaterialApp(
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}