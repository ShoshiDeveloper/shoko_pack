import 'package:flutter/material.dart';
import 'package:shoko_ui/shoko_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SThemeWidget(
        shokoUITheme: STheme(
          buttonTheme: SButtonTheme(
            color: Colors.white
          )
        ),
        child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 345,
            ),
            SButton(
              onTap: () {},
              childPosition: ButtonChildPosition.start,
              color: Colors.amber,
              child: Text('Create project', style: TextStyle(color: Colors.black),)
            ),
          ],
        )
      )
    );
  }
}
