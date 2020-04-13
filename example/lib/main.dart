import 'package:example/screens/presentation_screen.dart';
import 'package:flutter/material.dart';

import 'indicators/emoji_indicator.dart';
import 'indicators/simple_indicator.dart';
import 'screens/example_indicator_screen.dart';
import 'screens/ice_cream_indicator_screen.dart';
import 'screens/plane_indicator_screen.dart';
import 'screens/article_example_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomRefreshIndicator demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      routes: {
        '/example': (context) => ExampleIndicatorScreen(),
        '/plane': (context) => PlaneIndicatorScreen(),
        '/ice_cream': (context) => IceCreamIndicatorScreen(),
        '/presentation': (context) => PresentationScreen(),
        '/article_example': (context) => ExampleScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Examples"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: <Widget>[
            RaisedButton(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text("Presentation"),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/presentation',
              ),
            ),
            const SizedBox(height: 15),
            RaisedButton(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text("Article example"),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/article_example',
                arguments: simpleIndicator,
              ),
            ),
            const SizedBox(height: 15),
            RaisedButton(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text("Simple"),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/example',
                arguments: simpleIndicator,
              ),
            ),
            const SizedBox(height: 15),
            RaisedButton(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text("Simple with list opacity"),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/example',
                arguments: simpleIndicatorWithOpacity,
              ),
            ),
            const SizedBox(height: 15),
            RaisedButton(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text("Plane"),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/plane',
              ),
            ),
            const SizedBox(height: 15),
            RaisedButton(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text("Ice cream"),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/ice_cream',
              ),
            ),
            const SizedBox(height: 15),
            RaisedButton(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text("Emoji"),
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/example',
                arguments: emojiIndicator,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
