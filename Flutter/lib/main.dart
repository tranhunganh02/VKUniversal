import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Image.network("data:image/jpeg;base64,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")
        ),
    );
  }
}
