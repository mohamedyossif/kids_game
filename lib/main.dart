import 'package:flutter/material.dart';
import 'package:kids_game/home.dart';
main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      
    );
  }
}