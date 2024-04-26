import 'package:flutter/material.dart';
import 'package:shoko_ui/shoko_ui.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ShokoUIKitThemeWidget(
      shokoUIKitTheme: const ShokoUIKitTheme(
        textFieldTheme: ShokoUIThemeTextField(
          isOutline: false
        ),
        switchTheme: ShokoUIThemeSwitch(
          backgroundColor: Colors.green,
          inactiveBackgroundColor: Colors.red,
          thumbColor: Colors.black,
          inactiveThumbColor: Colors.white
        )
      ),
      child: PageView(
        controller: controller,
        children: const [
          ButtonsPage(),
          SwitchPage(),
          RadioPage(),
          TextFieldsPage()
        ],
      )
    );
  }
}

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  ShokoUIButton.expanded(
                    isChildAtCenter: true,
                   // isOutline: true,
                   prefix: Icon(Icons.supervised_user_circle_rounded, color: Colors.white),
                   child: Text('Fd', style: TextStyle(fontSize: 16, color: Colors.white)),
                              ),
                  ShokoUIButton(
                     // isOutline: true,
                     prefix: Icon(Icons.supervised_user_circle_rounded, color: Colors.white),
                     child: Text('Fd', style: TextStyle(fontSize: 16, color: Colors.white)),
                                ),
                  
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}


class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {

  bool s = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShokoUISwitch(
                insidePadding: 6,
                backgroundColor: const Color.fromRGBO(108, 99, 255, 1),
                thumbColor: Colors.white,
                onChange: (newValue) {
                  setState(() {
                    s = newValue;
                  });
                },
                value: s
              ),
              ShokoUISwitch(
                insidePadding: 6,
                onChange: (newValue) {
                  setState(() {
                    s = newValue;
                  });
                },
                value: s
              )
            ]
          )
        )
      )
    );
  }
}

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  bool s = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          child: ShokoUIRadio(
            value: s,
            childPosition: ShokoUIRadioChildPosition.left,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            child: const Text('Enable music'),
            onChange: (newValue) {
              setState(() {
                s = newValue;
              });
            },
          )
        )
      )
    );
  }
}

class TextFieldsPage extends StatelessWidget {
  const TextFieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 45),
              ShokoUITextField(
                maxSymbols: 3,
                obscureText: true,
                validator: (value) {
                  return value == 'Some';
                },
                isError: false,
                label: 'Header',
                controller: TextEditingController()
              )
            ]
          )
        )
      )
    );
  }
}