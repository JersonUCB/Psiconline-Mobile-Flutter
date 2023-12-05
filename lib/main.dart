import 'package:flutter/material.dart';
import 'package:proyecto_psiconline_mobile/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación Psiconline',
      home: Home(),
    );
  }
}
