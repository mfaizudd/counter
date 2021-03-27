import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: CounterPage(title: 'Counter'),
    );
  }
}

class CounterPage extends StatefulWidget {
  CounterPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
      prefs.setInt('counter', _counter);
    });
  }

  void _decrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_counter <= 0) {
        return;
      }
      _counter--;
      prefs.setInt('counter', _counter);
    });
  }

  void _resetCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = 0;
      prefs.setInt('counter', _counter);
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
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
            width: 200,
            height: 240,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.all(10),
                    child: new Tooltip(
                      message: "Reset",
                      child: new RawMaterialButton(
                        shape: new CircleBorder(),
                        elevation: 1.0,
                        fillColor: Colors.blue,
                        child: Icon(Icons.delete),
                        onPressed: _resetCounter,
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 80,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        child: new Tooltip(
                          message: "Decrease",
                          child: new RawMaterialButton(
                            shape: new CircleBorder(),
                            elevation: 1.0,
                            fillColor: Colors.blue,
                            child: Icon(Icons.remove),
                            onPressed: _decrementCounter,
                          ),
                        )),
                    Container(
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        child: new Tooltip(
                          message: "Increase",
                          child: new RawMaterialButton(
                            shape: new CircleBorder(),
                            elevation: 1.0,
                            fillColor: Colors.blue,
                            child: Icon(Icons.add),
                            onPressed: _incrementCounter,
                          ),
                        ))
                  ],
                ),
              ],
            )) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
