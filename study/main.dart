import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_application_177/src/random_list.dart';
import 'src/random_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: RandomList(),
    );
  }
  
}