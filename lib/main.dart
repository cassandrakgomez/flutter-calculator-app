import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState(); 
}

class _MainAppState extends State<MainApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF47748b),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 4,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 30, 17, 54),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 4,
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: CalculatorPage(toggleTheme: _toggleTheme),
    );
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
}

class CalculatorPage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const CalculatorPage({super.key, required this.toggleTheme});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  static const List<String> _buttons = [
    'C', 'DEL', '÷', 'x',
    '7', '8', '9', '-',
    '4', '5', '6', '+',
    '1', '2', '3', '=',
    '0', '.',
  ];

  String history = '';
  String mainDisplay = '0';
  String? firstOperand;
  String? operator;
  bool shouldResetMain = false;

  // Define gradients
  final lightGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB), Color(0xFF90CAF9)],
  );

  final darkGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromARGB(255, 91, 85, 161), Color.fromARGB(255, 71, 57, 142), Color.fromARGB(255, 8, 23, 108)],
  );

  @override
  Widget build(BuildContext context) {
    // Check the current theme directly
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cassie's Calculator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
            tooltip: 'Toggle Light/Dark Mode',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? darkGradient : lightGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  history,
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.grey[700],
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  mainDisplay,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: _buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final label = _buttons[index];
                    return ElevatedButton(
                      onPressed: () => _onButtonPressed(label),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? const Color.fromARGB(255, 106, 101, 175) : const Color.fromARGB(255, 159, 204, 241),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(fontSize: 24),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onButtonPressed(String label) {
    setState(() {
      if (label == 'C') {
        mainDisplay = '0';
        history = '';
        firstOperand = null;
        operator = null;
      } else if (label == 'DEL') {
        if (mainDisplay.length > 1) {
          mainDisplay = mainDisplay.substring(0, mainDisplay.length - 1);
        } else {
          mainDisplay = '0';
        }
      } else if (['+', '-', 'x', '÷'].contains(label)) {
        firstOperand = mainDisplay;
        operator = label;
        history = '$mainDisplay $label';
        shouldResetMain = true;
      } else if (label == '=') {
        if (firstOperand != null && operator != null) {
          double num1 = double.parse(firstOperand!);
          double num2 = double.parse(mainDisplay);
          double result;

          switch (operator) {
            case '+':
              result = num1 + num2;
              break;
            case '-':
              result = num1 - num2;
              break;
            case 'x':
              result = num1 * num2;
              break;
            case '÷':
              result = num1 / num2;
              break;
            default:
              result = 0;
          }

          history = '$firstOperand $operator $mainDisplay =';
          mainDisplay = result.toString();
          firstOperand = null;
          operator = null;
        }
      } else if (label == '.') {
        if (!mainDisplay.contains('.')) {
          mainDisplay += '.';
        }
      } else {
        if (mainDisplay == '0' || shouldResetMain) {
          mainDisplay = label;
          shouldResetMain = false;
        } else {
          mainDisplay += label;
        }
      }
    });
  }
}
