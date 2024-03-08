import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _outputFull = "";
  final List<String> _history = [];
  String _operand = "";
  double _num1 = 0.0;
  double _num2 = 0.0;
  final int _inputLimit = 10;
  bool _isDarkMode = false;

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _operand = "";
      _num1 = 0.0;
      _num2 = 0.0;
      _output = "0";
      _outputFull = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      _num1 = double.parse(_output);
      _operand = buttonText;
      _outputFull = _outputFull + buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".") || _output.length >= _inputLimit) {
        return;
      } else {
        _output = _output + buttonText;
        _outputFull = _outputFull + buttonText;
      }
    } else if (buttonText == "=") {
      _num2 = double.parse(_output);

      if (_operand == "+") {
        _output = (_num1 + _num2).toString();
      }
      if (_operand == "-") {
        _output = (_num1 - _num2).toString();
      }
      if (_operand == "*") {
        _output = (_num1 * _num2).toString();
      }
      if (_operand == "/") {
        _output = (_num1 / _num2).toString();
      }

      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
      if (_history.length == 1) {
        _history.removeAt(0);
      }
      _history.add("$_outputFull=$_output");
      _outputFull = _output;
    } else {
      if (_output.length >= _inputLimit) {
        return;
      }
      _output = _output == "0" ? buttonText : _output + buttonText;
      _outputFull = _outputFull == "0" ? buttonText : _outputFull + buttonText;
    }

    setState(() {
      _output = _output;
      _outputFull = _outputFull;
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            elevation: 5,
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Basic Calculator"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Text(
                  _outputFull,
                  style: const TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Text(
                  _output,
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              Column(children: [
                for (var i = 0; i < _history.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      _history[_history.length - 1 - i],
                      style:
                          const TextStyle(fontSize: 18, color: Colors.blueGrey),
                    ),
                  ),
              ]),
              Container(
                child: Column(
                  children: [
                    Row(children: [
                      buildButton("7", Colors.blueGrey[50]!, Colors.black),
                      buildButton("8", Colors.blueGrey[50]!, Colors.black),
                      buildButton("9", Colors.blueGrey[50]!, Colors.black),
                      buildButton("/", Colors.blueGrey, Colors.white),
                    ]),
                    Row(children: [
                      buildButton("4", Colors.blueGrey[50]!, Colors.black),
                      buildButton("5", Colors.blueGrey[50]!, Colors.black),
                      buildButton("6", Colors.blueGrey[50]!, Colors.black),
                      buildButton("*", Colors.blueGrey, Colors.white),
                    ]),
                    Row(children: [
                      buildButton("1", Colors.blueGrey[50]!, Colors.black),
                      buildButton("2", Colors.blueGrey[50]!, Colors.black),
                      buildButton("3", Colors.blueGrey[50]!, Colors.black),
                      buildButton("-", Colors.blueGrey, Colors.white),
                    ]),
                    Row(children: [
                      buildButton(".", Colors.blueGrey[50]!, Colors.black),
                      buildButton("0", Colors.blueGrey[50]!, Colors.black),
                      buildButton("00", Colors.blueGrey[50]!, Colors.black),
                      buildButton("+", Colors.blueGrey, Colors.white),
                    ]),
                    Row(children: [
                      buildButton("CLEAR", Colors.redAccent, Colors.white),
                      buildButton("=", Colors.green, Colors.white),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
