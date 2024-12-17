import 'package:CalBaht/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Désactive le bandeau de débogage
      theme: ThemeData(
        useMaterial3: true,  // Active Material 3
      ),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 255, 154, 59),
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.black,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.calculate, color: Colors.white),
            icon: Icon(Icons.calculate, color: Colors.white),
            label: 'CalBaht',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.note, color: Colors.white),
            icon: Icon(Icons.note, color: Colors.white),
            label: 'Mémo',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.train, color: Colors.white),
            icon: Icon(Icons.train, color: Colors.white),
            label: 'Métro',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map, color: Colors.white),
            icon: Icon(Icons.map, color: Colors.white),
            label: 'Maps',
          ),
        ],
      ),
      body: <Widget>[

        /// CalBaht page
        Calculator_App(),

        /// Mémo page
        Container(
          color: Colors.black, // Fond noir
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              ...[["BAHT", "EURO"],["10฿", "0,25€"],["20฿", "0,50€"],["30฿", "0,75€"],["40฿", "1,00€"],["50฿", "1,25€"],["60฿", "1,50€"],["70฿", "1,75€"],["80฿", "2,00€"],["90฿", "2,25€"],["100฿", "2,50€"],["150฿", "3,75€"],["200฿", "5,00€"],["250฿", "6,25€"],["300฿", "7,50€"],["350฿", "8,75€"],["400฿", "10,00€"],["450฿", "11,25€"],["500฿", "12,50€"],["550฿", "13,75€"],["600฿", "15,00€"],["700฿", "17,50€"],["800฿", "20,00€"],["900฿", "22,50€"],["1000฿", "25,00€"],["2000฿", "50,00€"],
              ].map((pair) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: pair.map((text) {
                    return Text(
                      text,
                      style: TextStyle(
                        fontSize: pair[0] == "BAHT" || pair[0] == "EURO" ? 24 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Texte en blanc pour contraster avec le fond noir
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ],
          ),
        ),

        /// Métro page
        Container(
          color: Colors.black, // Fond noir
          child: ListView(
            //afficher une image 
          ),
        ),

        /// Maps page
        Container(
          color: Colors.black, // Fond noir
          child: ListView(
            //afficher une image 
          ),
        ),

      ][currentPageIndex],
    );
  }
}

class Calculator_App extends StatefulWidget {
    const Calculator_App({
        super.key
    });

    @override
    State < Calculator_App > createState() => _Calculator_AppState();
}

////////////////////////////////////////////////////////////////////////////////////////////////////Fonction page 1

class _Calculator_AppState extends State < Calculator_App > {
  double firstnumber = 0.0;
  double secondnumber = 0.0;
  var input = '';
  var output = '0.00';
  var outputEuro = '0.00';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;
  bool isEuroToBaht = false;
  bool isMemo = true;

  onButtonClick(value) {
    if (value == '☰') {
      return;
    }
    if (value == '.' && (input.endsWith('.') || input.endsWith('+') || input.endsWith('/') || input.endsWith('x') || input.endsWith('-') || input.endsWith('%'))) {
      input = input.substring(0, input.length - 1);
    }
    if (value == '%' && (input.endsWith('+-') || input.endsWith('/-') || input.endsWith('x-') || input.endsWith('--') || input.endsWith('.'))) {
        return;
    }
    if (value == '%' && (input.endsWith('+') || input.endsWith('/') || input.endsWith('x') || input.endsWith('-'))) {
      input = input.substring(0, input.length - 1);
    }
    if (value == '/' && (input.endsWith('+-') || input.endsWith('/-') || input.endsWith('x-') || input.endsWith('--') || input.endsWith('.'))) {
        return;
    }
    if (value == '/' && (input.endsWith('+') || input.endsWith('/') || input.endsWith('x') || input.endsWith('-') || input.endsWith('%'))) {
        input = input.substring(0, input.length - 1);
    }
    if (value == '+' && (input.endsWith('+-') || input.endsWith('/-') || input.endsWith('x-') || input.endsWith('--') || input.endsWith('.'))) {
        return;
    }
    if (value == '+' && (input.endsWith('+') || input.endsWith('/') || input.endsWith('x') || input.endsWith('-') || input.endsWith('%'))) {
        input = input.substring(0, input.length - 1);
    }
    if (value == 'x' && (input.endsWith('+-') || input.endsWith('/-') || input.endsWith('x-') || input.endsWith('--') || input.endsWith('.'))) {
        return;
    }
    if (value == 'x' && (input.endsWith('+') || input.endsWith('/') || input.endsWith('x') || input.endsWith('-') || input.endsWith('%'))) {
        input = input.substring(0, input.length - 1);
    }
    if (input == '-' && value == '-') {
        return;
    }
    if (value == '-' && input.endsWith('%')) {
        input = input.substring(0, input.length - 1);
    }
    if (value == '-' && (input.endsWith('+-') || input.endsWith('/-') || input.endsWith('x-') || input.endsWith('--') || input.endsWith('.'))) {
      return;
    }
    if (input == '' && (value == '+' || value == 'x' || value == '/' || value == '%' || value == '.')) {
      return;
    }
    if (value == 'AC') {
      input = '';
      output = '0.00';
      outputEuro = '0.00';
    } else if (value == '⌫') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        if (input == "-") {
          input = '';
        }
      }
      if (input == '') {
        output = '0.00';
        outputEuro = '0.00';
      }
    } else if (value == '+/-') {
      if (!input.contains('+') && input.split('-').length <= 2 && !input.contains('x') && !input.contains('/') && !input.contains('+-') && !input.contains('/-') && !input.contains('x-')) {
        if (input == output) {
          if (output.startsWith('-')) {
            output = output.substring(1, output.length - 0);
            input = output;
          } else {
            output = '-' + output;
            input = output;
          }
        } else {
          if (input.startsWith('-')) {
            input = input.substring(1, input.length - 0);
          } else {
            input = '-' + input;
          }
        }
      } else {
        return;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34.0;
    }
    if (value == '=') {
      if (((double.parse(output) * 100).ceil() / 100).toStringAsFixed(2).endsWith('.00')){
        input = output.substring(0, output.length - 3);
      } else {
        input = output;
      }
      if (input == "0"){
        input = "";
      }
    }
    if (input.isNotEmpty && value != "AC" && value != "=" && !input.endsWith('+-') && !input.endsWith('/-') && !input.endsWith('x-') && !input.endsWith('--') && !input.endsWith('%') && !input.endsWith('+') && !input.endsWith('/') && !input.endsWith('x') && !input.endsWith('-')) {
      var userInput = input;
      userInput = input.replaceAll('x', '*');
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      var finalValueEuro = isEuroToBaht ? finalValue * 40 : finalValue / 40;
      output = (((double.parse(finalValue.toString()) * 100).ceil() / 100).toStringAsFixed(2));
      outputEuro = (((double.parse(finalValueEuro.toString()) * 100).ceil() / 100).toStringAsFixed(2));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          hideInput ? '' : input + (isEuroToBaht ? '€' : '฿'),
                          style: const TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 10,
                      child: Text(
                        output + (isEuroToBaht ? '€' : '฿'),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 10,
                      child: Text(
                        outputEuro + (isEuroToBaht ? '฿' : '€'),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: outputSize,
                            color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(children: [
            button(
              text: isEuroToBaht ? '€ → ฿' : '฿ → €', buttonBGcolor: operatorcolor, tColor: orangecolor,
              onPressed: () {
                setState(() {
                  isEuroToBaht = !isEuroToBaht;
                  var temp = output;
                  output = outputEuro;
                  outputEuro = temp;
                  if (((double.parse(output) * 100).ceil() / 100).toStringAsFixed(2).endsWith('.00')){
                    input = output.substring(0, output.length - 3);
                  } else {
                    input = output;
                  }
                  if (input == "0"){
                    input = "";
                  }
                });
              },
            ),
          ]),
          Row(children: [
            button(text: '+/-', buttonBGcolor: operatorcolor, tColor: orangecolor),
            button(text: '⌫', buttonBGcolor: operatorcolor, tColor: orangecolor),
            button(text: '%', buttonBGcolor: orangecolor),
            button(text: '/', buttonBGcolor: orangecolor),
          ]),
          Row(children: [
            button(text: '7'),
            button(text: '8'),
            button(text: '9'),
            button(text: 'x', buttonBGcolor: orangecolor),
          ]),
          Row(children: [
            button(text: '4'),
            button(text: '5'),
            button(text: '6'),
            button(text: '-', buttonBGcolor: orangecolor),
          ]),
          Row(children: [
            button(text: '1'),
            button(text: '2'),
            button(text: '3'),
            button(text: '+', buttonBGcolor: orangecolor),
          ]),
          Row(children: [
            button(text: 'AC', tColor: orangecolor, buttonBGcolor: operatorcolor),
            button(text: '0'),
            button(text: '.'),
            button(text: '=', buttonBGcolor: orangecolor),
          ]),
        ],
      ),
    );
  }

  Widget button({
    required String text,
    Color tColor = Colors.white,
    Color buttonBGcolor = buttonColor,
    VoidCallback ? onPressed,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(22),
            backgroundColor: buttonBGcolor,
          ),
          onPressed: onPressed ?? () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}