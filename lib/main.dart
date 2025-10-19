import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cassie's Calculator", 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 4,
          ),
        ),
        home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatelessWidget{
  const CalculatorPage({super.key});

static const List<String> _buttons = [
  'C', 'DEL', '÷', 'x',
    '7', '8', '9', '-',
    '4', '5', '6', '+',
    '1', '2', '3', '=',
    '0', '.', 
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cassie's Calculator")),
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
            const SizedBox(height: 8),

            // main display
            Align(
              alignment: Alignment.centerRight, 
              child: Text(
                '0',
                style:TextStyle(fontSize: 48, fontWeight: FontWeight.bold,),),
            ),
            const SizedBox(height: 16),

            // button grid
            Expanded(
              child: GridView.builder(
                itemCount: _buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final label = _buttons[index];
                  return ElevatedButton(
                    onPressed: () {
                      debugPrint('Pressed: $label');
                    }, 
                    child: Text(label, style: const TextStyle(fontSize: 24),
                    ),
                  ); 
                },
              ),
            ),  
          ],
        ),
      ),
    );
  }
}
