import 'package:flutter/material.dart';
import 'package:packages_app/config/theme/theme.dart';
import 'package:packages_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const Home(),
    );
  }
}
