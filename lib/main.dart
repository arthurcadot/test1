import 'package:test1/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
    runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Calculator_App(),
    ));
}

class Calculator_App extends StatefulWidget {
    const Calculator_App({
        super.key
    });

    @override
    State < Calculator_App > createState() => _Calculator_AppState();
}

class _Calculator_AppState extends State < Calculator_App > {
    // Variables
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
        if (value == '.' &&
            (input.endsWith('.') ||
                input.endsWith('+') ||
                input.endsWith('/') ||
                input.endsWith('x') ||
                input.endsWith('-') ||
                input.endsWith('%'))) {
            input = input.substring(0, input.length - 1);
        }
        if (value == '%' &&
            (input.endsWith('+-') ||
                input.endsWith('/-') ||
                input.endsWith('x-') ||
                input.endsWith('--') ||
                input.endsWith('.'))) {
            return;
        }
        if (value == '%' &&
            (input.endsWith('+') ||
                input.endsWith('/') ||
                input.endsWith('x') ||
                input.endsWith('-'))) {
            input = input.substring(0, input.length - 1);
        }
        if (value == '/' &&
            (input.endsWith('+-') ||
                input.endsWith('/-') ||
                input.endsWith('x-') ||
                input.endsWith('--') ||
                input.endsWith('.'))) {
            return;
        }
        if (value == '/' &&
            (input.endsWith('+') ||
                input.endsWith('/') ||
                input.endsWith('x') ||
                input.endsWith('-') ||
                input.endsWith('%'))) {
            input = input.substring(0, input.length - 1);
        }
        if (value == '+' &&
            (input.endsWith('+-') ||
                input.endsWith('/-') ||
                input.endsWith('x-') ||
                input.endsWith('--') ||
                input.endsWith('.'))) {
            return;
        }
        if (value == '+' &&
            (input.endsWith('+') ||
                input.endsWith('/') ||
                input.endsWith('x') ||
                input.endsWith('-') ||
                input.endsWith('%'))) {
            input = input.substring(0, input.length - 1);
        }
        if (value == 'x' &&
            (input.endsWith('+-') ||
                input.endsWith('/-') ||
                input.endsWith('x-') ||
                input.endsWith('--') ||
                input.endsWith('.'))) {
            return;
        }
        if (value == 'x' &&
            (input.endsWith('+') ||
                input.endsWith('/') ||
                input.endsWith('x') ||
                input.endsWith('-') ||
                input.endsWith('%'))) {
            input = input.substring(0, input.length - 1);
        }
        if (input == '-' && value == '-') {
            return;
        }
        if (value == '-' && input.endsWith('%')) {
            input = input.substring(0, input.length - 1);
        }
        if (value == '-' &&
            (input.endsWith('+-') ||
                input.endsWith('/-') ||
                input.endsWith('x-') ||
                input.endsWith('--') ||
                input.endsWith('.'))) {
            return;
        }
        if (input == '' &&
            (value == '+' || value == 'x' || value == '/' || value == '%' || value == '.')) {
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
            if (!input.contains('+') &&
                input.split('-').length <= 1 &&
                !input.contains('x') &&
                !input.contains('/') &&
                !input.contains('+-') &&
                !input.contains('/-') &&
                !input.contains('x-')) {
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

        if (input.isNotEmpty &&
            value != "AC" &&
            value != "=" &&
            !input.endsWith('+-') &&
            !input.endsWith('/-') &&
            !input.endsWith('x-') &&
            !input.endsWith('--') &&
            !input.endsWith('%') &&
            !input.endsWith('+') &&
            !input.endsWith('/') &&
            !input.endsWith('x') &&
            !input.endsWith('-')) {
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
                                            alignment: Alignment.topRight,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              reverse: true,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => PageDeux()),
                                                  );
                                                });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                  backgroundColor: orangecolor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12), // Si tu veux un bouton rond
                                                  ),
                                                ),
                                                child: Text(
                                                  "☰",
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                            child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                    reverse: true,
                                                    child: Text(
                                                        hideInput ? '' : input,
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
                            text: isEuroToBaht ? '€ → ฿' : '฿ → €',
                            buttonBGcolor: operatorcolor,
                            tColor: orangecolor,
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
                        button(
                            text: '+/-',
                            buttonBGcolor: operatorcolor,
                            tColor: orangecolor),
                        button(
                            text: '⌫',
                            buttonBGcolor: operatorcolor,
                            tColor: orangecolor),
                        button(
                            text: '%', buttonBGcolor: orangecolor),
                        button(
                            text: '/', buttonBGcolor: orangecolor),
                    ]),
                    Row(children: [
                        button(text: '7'),
                        button(text: '8'),
                        button(text: '9'),
                        button(
                            text: 'x', buttonBGcolor: orangecolor),
                    ]),
                    Row(children: [
                        button(text: '4'),
                        button(text: '5'),
                        button(text: '6'),
                        button(
                            text: '-', buttonBGcolor: orangecolor),
                    ]),
                    Row(children: [
                        button(text: '1'),
                        button(text: '2'),
                        button(text: '3'),
                        button(
                            text: '+', buttonBGcolor: orangecolor),
                    ]),
                    Row(children: [
                        button(
                            text: 'AC', tColor: orangecolor, buttonBGcolor: operatorcolor),
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

class PageDeux extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter, // Alignement du tableau en bas de l'écran
            child: SingleChildScrollView(
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text(
                          'BATH',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text(
                          'EURO',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('10฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('0,25€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('20฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('0,50€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('40฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('1,00€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('50฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('1,25€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('100฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('2,50€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('200฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('5,00€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('300฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('7,50€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('400฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('10,00€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('500฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('12,50€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('600฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('15,00€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('700฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('17,50€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('800฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('20,00€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('900฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('22,50€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('1000฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('25,00€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('2000฿', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        child: Text('50,00€', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calculator_App()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: orangecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "✘",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
