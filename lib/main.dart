import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snazzy Calculator', 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
          ),
        ),
        home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatelessWidget{
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(/*replace with icon*/),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // history text
            Align(
              alignment: Alignment.centerRight,
              child: Text('History will appear here', style: TextStyle(color: Colors.grey, fontSize: 18),),
            ),
          ],
        ),
          
        ),
      ),
    );   
  }
}
