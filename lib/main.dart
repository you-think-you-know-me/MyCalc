
import 'package:first_app/graph.dart';
import 'package:first_app/scientific.dart';
import 'package:first_app/theme/theme_constants.dart';
import 'package:first_app/theme/theme_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String message = " ";

  Widget buildButton(String buttonText) {
    return new Expanded(
        child: Container(
            child: SizedBox(
                width: 70,
                height: 70,
                child: new ElevatedButton(
                  onPressed: () => buttonPressed(buttonText),
                  child: Text(buttonText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                ))));
  }

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  String _message = "";

  buttonPressed(String buttonText) {
    _message = "";
    if (buttonText == "Clear") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "x" ||
        buttonText == "/" ||
        buttonText == "%") {
      operand = buttonText;
      num1 = double.parse(output);
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        _message = "Already has a decimal.";
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "x") {
        _output = (num1 * num2).toString();
      }
      if (operand == "%") {
        _output = (num1 * num2 / 100).toString();
      }
      if (operand == "/") {
        if (num2 != 0)
          _output = (num1 / num2).toString();
        else {
          _message = "Division by 0 is invalid.";
          return;
        }
      }
      operand = "";
      num1 = 0.0;
      num2 = 0.0;
    } else {
      _output += buttonText;
    }
    setState(() {
      message = _message;
      output = double.parse(_output).toStringAsFixed(4);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: Center(
        child: new Column(children: [
          new Row(children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Icon(
              Icons.calculate,
              size: 50,
            ),
            Text(
              "MyCalc",
              style: TextStyle(fontSize: 50, color: Colors.white),
            )
          ]),
          Divider(
            thickness: 0.2,
            color: Colors.white,
          ),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                InkWell(
                  child: new Row(
                    children: [
                      Text(
                        "Simple Calculator",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )
                    ],
                  ),
                  onTap: (){Navigator.push(context,MaterialPageRoute(builder:(context)=> MyHomePage()));},
                  
                ),
                Divider(
                  thickness: 0.2,
                  color: Colors.white,
                ),
                InkWell(
                  child: new Row(children: [
                    Text(
                      "Scientific Calculator",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )
                  ]),
                  onTap: (){Navigator.push(context,MaterialPageRoute(builder:(context)=>const Scientific()));},
                ),
                Divider(
                  thickness: 0.2,
                  color: Colors.white,
                ),
                InkWell(
                  child: new Row(children: [
                    Text(
                      "Graph",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )
                  ]),
                  onTap: (){Navigator.push(context,MaterialPageRoute(builder:(context)=>const Graph()));},
                ),
              ]))
        ]),
      )),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("MyCalc"),
        actions: [
          Switch(
              value: _themeManager.themeMode == ThemeMode.dark,
              onChanged: (newvalue) {
                _themeManager.toggleTheme(newvalue);
              })
        ],
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
              child: new Container(
                  color: _themeManager.themeMode == ThemeMode.dark
                      ? Colors.black
                      : Colors.white,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
                  child: ListView(children: [
                    new Text(
                      output,
                      style: new TextStyle(
                          fontSize: 55.0,
                          fontWeight: FontWeight.bold,
                          color: _themeManager.themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black),
                    ),
                  ]))),
          new Container(
              color: _themeManager.themeMode == ThemeMode.dark
                  ? Colors.black
                  : Colors.white,
              height: 123,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 12),
              child: Column(children: [
                new Text(
                  message,
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    color: _themeManager.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                new Expanded(
                    child: new Divider(
                  color: _themeManager.themeMode == ThemeMode.dark
                      ? Colors.black
                      : Colors.white,
                ))
              ])),
          new Column(children: <Widget>[
            new Row(children: <Widget>[
              buildButton("Clear"),
              buildButton("="),
            ]),
            SizedBox(
              height: 0.2,
            ),
            new Row(children: <Widget>[
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("/"),
            ]),
            new Row(children: <Widget>[
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("x"),
            ]),
            SizedBox(
              height: 0.2,
            ),
            new Row(children: <Widget>[
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-"),
            ]),
            new Row(children: <Widget>[
              buildButton("."),
              buildButton("0"),
              buildButton("%"),
              buildButton("+"),
            ]),
          ])
        ],
      ),
    );
  }
}
