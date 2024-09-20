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
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundTheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyWidget(),
            Container(
              color: context.theme.buttonTheme.color,
              height: 65,
              width: 25,
            ),
            SButton.expanded(
              onTap: () {
                if(state) {
                  context.changeTheme(const STheme(
                    backgroundTheme: SBackgroundTheme(primary: Colors.indigo, secondary: Colors.black, tertiary: Colors.black, brand: Colors.black, brandLight: Colors.black, success: Colors.black, successLight: Colors.black, alert: Colors.black, alertLight: Color.fromRGBO(1, 1, 1, 1)),
                    contentTheme: SContentTheme(primary: Colors.black, secondary: Colors.black, tertiary: Colors.black, brand: Colors.black, success: Colors.black, alert: Colors.black),
                    buttonTheme: SButtonTheme(
                      color: Colors.white
                    )
                  ));
                } else {
                  context.changeTheme(const STheme(
                    backgroundTheme: SBackgroundTheme(primary: Colors.lightBlue, secondary: Colors.black, tertiary: Colors.black, brand: Colors.black, brandLight: Colors.black, success: Colors.black, successLight: Colors.black, alert: Colors.black, alertLight: Color.fromRGBO(1, 1, 1, 1)),
                    contentTheme: SContentTheme(primary: Colors.white, secondary: Colors.black, tertiary: Colors.black, brand: Colors.black, success: Colors.black, alert: Colors.black),
                    buttonTheme: SButtonTheme(
                      color: Colors.black
                    )
                  ));
                }

                state = !state;
                print(context.theme.contentTheme.primary);
              },
              child: Text('Create project', style: context.theme.contentStyles.body2(color: context.theme.contentTheme.primary))
            ),
          ],
        )
      )
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.buttonTheme.color,
      height: 345,
      width: 25,
    );
  }
}