import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickpad/Screens/homescreen.dart';

void main()=> runApp(  
   ProviderScope(child: QuickPad()),
);

class QuickPad extends StatelessWidget {
  const QuickPad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
       debugShowCheckedModeBanner: false,
       home: Homescreen(),
    );
  }
}