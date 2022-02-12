import 'package:flutter/material.dart';
import 'package:tarea_03/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: HomePage(),
    );
  }
}
